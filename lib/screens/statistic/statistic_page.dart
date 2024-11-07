import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/repositories/repository.dart';
import 'package:book_store_manager/screens/statistic/views/row_data.dart';
import 'package:book_store_manager/utils/currency_utils.dart';
import 'package:book_store_manager/widgets/dialogs/sales_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../themes/texts.dart';
import '../../widgets/statistic_item.dart';
import 'bloc/statistic_bloc.dart';
import 'views/statistic_line_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/statistic_pie_chart.dart';
import 'package:gap/gap.dart';
import 'views/month_selector.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisticBloc(
        RepositoryProvider.of<AppRepository>(context).orderRepository,
      )..add(LoadStatisticData(selectedMonth: DateTime.now())),
      child: const _StatisticContent(),
    );
  }
}

class _StatisticContent extends StatelessWidget {
  const _StatisticContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: true,
              elevation: 0,
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              title: Text('Thống kê', style: AppTexts.appbarTitle),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppIcons.chart),
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomRight,
                    opacity: 0.2,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.orangeAccent[700]!,
                      Colors.orangeAccent[700]!.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trích xuất thống kê tháng',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        MonthSelector(),
                      ],
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        BlocBuilder<StatisticBloc, StatisticState>(
                          builder: (context, state) {
                            return StatisticItem(
                              title: 'Tổng đơn',
                              content: state.isLoading
                                  ? '-/-'
                                  : state.orders.length.toStringAsFixed(0),
                              imgPath: AppIcons.order,
                            );
                          },
                        ),
                        const Gap(4),
                        BlocBuilder<StatisticBloc, StatisticState>(
                          builder: (context, state) {
                            if (state.isLoading) {
                              return StatisticItem(
                                title: 'Đơn xong',
                                content: '-/-',
                                color: Colors.lightBlueAccent[700],
                                imgPath: AppIcons.complete,
                              );
                            }
                            int count = 0;
                            for (var ele in state.orders) {
                              if (ele.status == 4) count++;
                            }
                            return StatisticItem(
                              title: 'Đơn xong',
                              content: count.toStringAsFixed(0),
                              color: Colors.lightBlueAccent[700],
                              imgPath: AppIcons.complete,
                            );
                          },
                        ),
                        const Gap(4),
                        BlocBuilder<StatisticBloc, StatisticState>(
                          builder: (context, state) {
                            if (state.isLoading) {
                              return StatisticItem(
                                title: 'Doanh thu',
                                content: '-/-',
                                color: Colors.amber[700],
                                imgPath: AppIcons.coin,
                              );
                            }

                            double t = 0;
                            for (var ele in state.orders) {
                              if (ele.status == 4) {
                                t += ele.totalPrice;
                              }
                            }

                            return StatisticItem(
                              title: 'Doanh thu',
                              content: CurrencyUtils.convertDoubletoKMB(t),
                              color: Colors.amber[700],
                              imgPath: AppIcons.coin,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: const Column(
                  children: [
                    Text(
                      'Biểu đồ số lượng đơn hàng',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Gap(16),
                    StatisticPieChart(),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: const Column(
                  children: [
                    Text(
                      'Biểu đồ lượt mua trong tháng',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Gap(8),
                    StatisticLineChart(),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                margin: const EdgeInsets.only(top: 4, bottom: 8),
                child: Column(
                  children: [
                    const Text(
                      'Thông tin khác',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    const Gap(4),
                    BlocBuilder<StatisticBloc, StatisticState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const RowData(
                            title: 'Số lượng đơn hủy',
                            content: '-/-',
                            contentStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          );
                        }
                        int count = 0;
                        double percent = 0;
                        if (state.completeOrders.isNotEmpty) {
                          for (var ele in state.orders) {
                            if (ele.status != 4) count++;
                          }
                          percent = count / state.orders.length;
                        }

                        return RowData(
                          title: 'Số lượng đơn hủy',
                          content:
                              '${count.toStringAsFixed(0)} (${percent.toStringAsFixed(2).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}%)',
                          contentStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                    BlocBuilder<StatisticBloc, StatisticState>(
                      builder: (context, state) {
                        int count = 0;
                        for (var ele in state.orders) {
                          for (var p in ele.products) {
                            count += p.count;
                          }
                        }
                        return Column(
                          children: [
                            RowData(
                              title: 'Tổng sản phẩm bán được',
                              content: count.toStringAsFixed(0),
                            ),
                            RowData(
                              title: 'Số sản phẩm trung bình mỗi đơn',
                              content: state.orders.isNotEmpty
                                  ? (count / state.orders.length)
                                      .toStringAsFixed(2)
                                  : '0',
                            ),
                          ],
                        );
                      },
                    ),
                    BlocBuilder<StatisticBloc, StatisticState>(
                      builder: (context, state) {
                        double total = 0;
                        for (var ele in state.orders) {
                          total += ele.totalPrice;
                        }
                        return RowData(
                          title: 'Giá trị trung bình mỗi đơn',
                          content: state.orders.isNotEmpty
                              ? CurrencyUtils.convertDoubletoKMB(
                                  total / state.orders.length)
                              : '0',
                          contentStyle: const TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                    BlocBuilder<StatisticBloc, StatisticState>(
                      builder: (context, state) {
                        double total = 0;
                        double f = 0;
                        for (var ele in state.orders) {
                          for (var p in ele.products) {
                            f += p.priceBPDiscount;
                            total += p.price;
                          }
                        }

                        return RowData(
                          title: 'Tổng tiền giảm giá',
                          content: CurrencyUtils.convertDoubletoKMB(f - total),
                          contentStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.tealAccent[700],
                          ),
                        );
                      },
                    ),
                    BlocBuilder<StatisticBloc, StatisticState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return TextButton(
                            onPressed: () {},
                            child: Text(
                              'Xem doanh số',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.themeColor,
                              ),
                            ),
                          );
                        }

                        return TextButton(
                          onPressed: () {
                            if (state.orders.isEmpty) {
                              Fluttertoast.showToast(
                                msg: 'Không có dữ liệu để thống kê',
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return SalesDialog(
                                    orders: state.orders,
                                    selectedMonth: state.selectedMonth!,
                                  );
                                },
                              );
                            }
                          },
                          child: Text(
                            'Xem doanh số',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.themeColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
