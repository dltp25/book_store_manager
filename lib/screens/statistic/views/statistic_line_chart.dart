import 'package:book_store_manager/extensions/datetime_ex.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../models/order_model.dart';
import '../bloc/statistic_bloc.dart';

class StatisticLineChart extends StatelessWidget {
  const StatisticLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BlocBuilder<StatisticBloc, StatisticState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: LoadingAnimationWidget.waveDots(
                color: AppColors.themeColor,
                size: 40,
              ),
            );
          }

          return LineChart(
            lineChartData(state.orders, state.selectedMonth!),
          );
        },
      ),
    );
  }

  Map<DateTime, int> countOrdersByDate(
      List<OrderModel> orders, int daysInMonth) {
    Map<DateTime, int> orderCountMap = {};

    if (orders.isNotEmpty) {
      List<DateTime> allDaysInMonth = List.generate(daysInMonth, (index) {
        return DateTime(orders.first.dateCreated.year,
            orders.first.dateCreated.month, index + 1);
      });

      for (var day in allDaysInMonth) {
        orderCountMap[day] = 0;
      }

      for (var order in orders) {
        DateTime date = order.dateCreated.toDateOnly();
        orderCountMap[date] = (orderCountMap[date] ?? 0) + 1;
      }
    }

    return orderCountMap;
  }

  int getMaxOrderCount(Map<DateTime, int> orderCountMap) {
    if (orderCountMap.isEmpty) {
      return 0;
    }
    return orderCountMap.values
        .reduce((value, element) => value > element ? value : element);
  }

  List<int> generateArray(int x, int numEntries) {
    List<int> result = [];
    int maxIndex = numEntries - 1;

    if (x >= maxIndex) {
      double interval = x / maxIndex;
      for (int i = 0; i <= maxIndex; i++) {
        result.add((interval * i).round());
      }
    } else {
      for (int i = 0; i <= x; i++) {
        result.add(i);
      }
    }
    return result;
  }

  LineChartData lineChartData(List<OrderModel> orders, DateTime month) {
    int maxX = month.getDaysOfMonth();
    Map<DateTime, int> ordersByDay = countOrdersByDate(orders, maxX);
    int maxY = getMaxOrderCount(ordersByDay);
    if (maxY == 0) {
      maxY = 1;
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
            getTitlesWidget: (value, meta) {
              final style = TextStyle(
                fontSize: 11,
                color: Colors.grey[700]!,
              );
              Widget text;

              if (value.toInt() == 1) {
                text = Text('Ngày', style: style);
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 4,
                  child: text,
                );
              }

              List<int> divisions = [];

              for (int i = 1; i <= maxX; i++) {
                if (i % 3 == 0) {
                  divisions.add(i);
                }
              }

              if (divisions.contains(value)) {
                text = Text(value.toStringAsFixed(0), style: style);
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 4,
                  child: text,
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              List<int> values = generateArray(maxY, 5);

              if (values.contains(value)) {
                return Text(
                  "${value.toInt()}",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[700]!,
                  ),
                  textAlign: TextAlign.center,
                );
              }
              return const SizedBox.shrink();
            },
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
      maxX: maxX.toDouble(),
      minY: 0,
      maxY: maxY.toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: ordersByDay.isNotEmpty
              ? ordersByDay.entries.map((entry) {
                  return FlSpot(
                      entry.key.day.toDouble(), entry.value.toDouble());
                }).toList()
              : [],
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
