import '../bloc/order_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'row_info_space.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
      builder: (context, state) {
        return OrderDetailsRowInfoSpace(
          title: 'Trạng thái đơn',
          content: state.isLoading
              ? ''
              : state.status == 0
                  ? 'Chờ xác nhận'
                  : state.status == 1
                      ? 'Đang chuẩn bị'
                      : state.status == 2
                          ? 'Chờ vận chuyển'
                          : state.status == 3
                              ? 'Đang vận chuyển'
                              : state.status == 4
                                  ? 'Đã hoàn thành'
                                  : 'Đã hủy',
          contentStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: state.status < 0
                ? Colors.red
                : state.status == 0
                    ? Colors.amber
                    : state.status < 4
                        ? Colors.blue
                        : state.status == 4
                            ? Colors.green
                            : Colors.red,
          ),
        );
      },
    );
  }
}
