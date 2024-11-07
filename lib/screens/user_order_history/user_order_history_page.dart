import 'dart:math';

import 'package:book_store_manager/models/user_model.dart';
import 'package:book_store_manager/repositories/repository.dart';
import 'package:book_store_manager/utils/converter.dart';
import '../../constant/app_icons.dart';
import 'bloc/user_order_history_bloc.dart';
import 'views/filter_button.dart';
import 'views/order_history_list.dart';
import 'views/statistic_1.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../themes/texts.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserOrderHistoryPage extends StatelessWidget {
  final UserModel user;

  const UserOrderHistoryPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserOrderHistoryBloc(
        RepositoryProvider.of<AppRepository>(context).userRepository,
        RepositoryProvider.of<AppRepository>(context).orderRepository,
      )..add(InitialEvent(userId: user.userId)),
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
                title: Text('Lịch sử mua hàng', style: AppTexts.appbarTitle),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orangeAccent[700]!,
                        Colors.orangeAccent[700]!.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    image: DecorationImage(
                      image: AssetImage(AppIcons.userGroupFill),
                      opacity: 0.2,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SizedBox(
                    height: 72,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(user.avatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${user.name} ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    user.isMale ? "(nam)" : "(nữ)",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                    size: 14,
                                  ),
                                  Text(
                                    " ${user.phoneNumber}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Statistic1(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              const Gap(20),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Column(
                  children: [
                    const Text(
                      'Thống kê lịch sử mua hàng (trong năm)',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(8),
                    SizedBox(
                      height: 200,
                      child: BlocBuilder<UserOrderHistoryBloc,
                          UserOrderHistoryState>(
                        builder: (context, state) {
                          return LineChart(
                            mainData(state.chartData),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
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
              const Expanded(child: OrderHistoryList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontSize: 11,
      color: Colors.grey[700]!,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('Tháng 1', style: style);
        break;
      case 3:
        text = Text('3', style: style);
        break;
      case 5:
        text = Text('5', style: style);
        break;
      case 7:
        text = Text('7', style: style);
        break;
      case 9:
        text = Text('9', style: style);
        break;
      case 11:
        text = Text('11', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontSize: 11,
      color: Colors.grey[700]!,
    );

    return Text("${value.toInt()}", style: style, textAlign: TextAlign.center);
  }

  LineChartData mainData(Map<int, int> datas) {
    double maxX = 0;
    for (var ele in datas.values) {
      maxX = max(maxX, ele.toDouble());
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          axisNameWidget: Align(
            alignment: Alignment.centerLeft,
            child: Text('Đơn', style: TextStyle(fontSize: 12)),
          ),
          sideTitles: SideTitles(showTitles: false),
          axisNameSize: 22,
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: maxX > 3 ? 2 : 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 22,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.black.withOpacity(0.3),
          width: 1,
        ),
      ),
      minX: 1,
      maxX: 12,
      minY: 0,
      maxY: maxX + 1,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 1; i < 13; i++)
              FlSpot(i.toDouble(), cvToDouble(datas[i]))
          ],
          isCurved: false,
          gradient: const LinearGradient(
            colors: [
              Color(0xFF50E4FF),
              Color(0xFF2196F3),
            ],
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF50E4FF),
                const Color(0xFF2196F3),
              ].map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
