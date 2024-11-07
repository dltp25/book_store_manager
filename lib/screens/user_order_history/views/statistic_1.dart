import '../bloc/user_order_history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'statistic_item.dart';

class Statistic1 extends StatelessWidget {
  const Statistic1({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<UserOrderHistoryBloc, UserOrderHistoryState>(
          builder: (context, state) {
            return StatisticItem(
              value: state.totalOrder,
              title: 'Tổng đơn',
            );
          },
        ),
        BlocBuilder<UserOrderHistoryBloc, UserOrderHistoryState>(
          builder: (context, state) {
            return StatisticItem(
              value: state.completeOrder,
              title: 'Hoàn thành',
              valueColor: Colors.blue,
            );
          },
        ),
        BlocBuilder<UserOrderHistoryBloc, UserOrderHistoryState>(
          builder: (context, state) {
            return StatisticItem(
              value: state.cancelOrder,
              title: 'Đơn hủy',
              valueColor: Colors.red,
            );
          },
        ),
      ],
    );
  }
}
