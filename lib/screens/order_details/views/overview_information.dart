import '../../../utils/date_time.dart';
import "../bloc/order_details_bloc.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'row_info_space.dart';

class OrderDetailsOverview extends StatelessWidget {
  const OrderDetailsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
      buildWhen: (previous, current) {
        return previous.orderData != current.orderData;
      },
      builder: (context, state) {
        return Column(
          children: [
            OrderDetailsRowInfoSpace(
              title: 'Mã đơn',
              content: state.orderData?.orderId,
            ),
            OrderDetailsRowInfoSpace(
              title: 'Khách hàng',
              content: state.orderData?.userName,
            ),
            OrderDetailsRowInfoSpace(
              title: 'Số điện thoại',
              content: state.orderData?.phone,
            ),
            OrderDetailsRowInfoSpace(
              title: 'Thời gian đặt',
              content: state.orderData != null
                  ? DateTimeUtils.orderTime(state.orderData!.dateCreated)
                  : '-/-',
            ),
            OrderDetailsRowInfoSpace(
              title: 'Phương thức vận chuyển',
              content: state.orderData?.transport,
            ),
            Divider(color: Colors.grey[300]!),
            OrderDetailsRowInfoSpace(
              title: 'Địa chỉ',
              content: state.orderData?.address,
              maxLines: 5,
              contentStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
            OrderDetailsRowInfoSpace(
              title: 'Ghi chú',
              content: state.orderData?.note != null
                  ? '"${state.orderData!.note}"'
                  : '',
              maxLines: 5,
              contentStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
              ),
            ),
            Divider(color: Colors.grey[300]!),
            OrderDetailsRowInfoSpace(
              title: 'Phương thức',
              content: state.orderData?.paymentMethod,
            ),
            OrderDetailsRowInfoSpace(
              title: 'Trạng thái',
              content: state.orderData?.paid != null
                  ? state.orderData!.paid
                      ? 'Đã thanh toán'
                      : 'Chưa thanh toán'
                  : '-/-',
              contentStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: state.orderData?.paid != null
                    ? state.orderData!.paid
                        ? Colors.green
                        : Colors.red
                    : Colors.red,
              ),
            ),
            Divider(color: Colors.grey[300]!),
          ],
        );
      },
    );
  }
}
