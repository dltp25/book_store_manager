import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/repositories/repository.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'bloc/order_done_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/search_order_field.dart';
import 'views/order_list.dart';
import 'views/calendar_button.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../themes/texts.dart';
import 'views/filter_button.dart';
import 'views/indicator.dart';

class OrderDonePage extends StatelessWidget {
  const OrderDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDoneBloc(
        RepositoryProvider.of<AppRepository>(context).orderRepository,
      )..add(InitialEvent()),
      child: Scaffold(
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
                title: Text('Đơn đã xong', style: AppTexts.appbarTitle),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppIcons.orderFill),
                      opacity: 0.2,
                      alignment: Alignment.centerRight,
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
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Thời gian: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          CalendarButton(),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          const Text(
                            'Tỷ lệ hoàn thành đơn',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Gap(12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 140,
                                width: 140,
                                child:
                                    BlocBuilder<OrderDoneBloc, OrderDoneState>(
                                  buildWhen: (previous, current) {
                                    return previous.isLoading !=
                                        current.isLoading;
                                  },
                                  builder: (context, state) {
                                    if (state.isLoading) {
                                      return Center(
                                        child: LoadingAnimationWidget.waveDots(
                                          color: AppColors.themeColor,
                                          size: 40,
                                        ),
                                      );
                                    }

                                    return PieChart(
                                      mainData(
                                        state.completeOrders.length,
                                        state.cancelOrders.length,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Gap(38),
                              const Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Indicator(
                                      color: Color(0xFFFFC300),
                                      text: 'Đơn hoàn thành',
                                      isSquare: true,
                                      size: 14,
                                    ),
                                    Gap(8),
                                    Indicator(
                                      color: Color(0xFF2196F3),
                                      text: 'Đơn hủy',
                                      isSquare: true,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(8),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Danh sách đơn hàng',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'Lọc: ',
                      style: TextStyle(fontSize: 12),
                    ),
                    FilterButton(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: SearchOrderField(),
              ),
              Gap(12),
              Expanded(
                child: OrderList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PieChartData mainData(int complete, int cancel) {
    return PieChartData(
      pieTouchData: PieTouchData(
        touchCallback: (FlTouchEvent event, pieTouchResponse) {},
      ),
      centerSpaceRadius: 0,
      sectionsSpace: 1,
      borderData: FlBorderData(
        show: false,
      ),
      sections: (complete + cancel == 0)
          ? [
              PieChartSectionData(
                value: 1,
                radius: 70,
                title: "0 đơn",
                color: Colors.grey,
                titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ]
          : [
              PieChartSectionData(
                value: complete.toDouble(),
                radius: 70,
                title: "${complete.toStringAsFixed(0)} đơn",
                color: const Color(0xFFFFC300),
                titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              PieChartSectionData(
                value: cancel.toDouble(),
                radius: 70,
                title: "${cancel.toStringAsFixed(0)} đơn",
                color: const Color(0xFF2196F3),
                titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
    );
  }
}
