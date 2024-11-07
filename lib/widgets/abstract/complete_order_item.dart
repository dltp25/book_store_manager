import '../../utils/date_time.dart';
import 'abstract_order_item.dart';
import 'package:flutter/material.dart';

import '../flag_cllip_path.dart';

class CompleteOrderItem extends AbstractOrderItem {
  const CompleteOrderItem({super.key, required super.order});

  @override
  buildFlag() {
    return ClipPath(
      clipper: FlagClipPath(),
      child: Container(
        color: Colors.blue[300],
        padding: const EdgeInsets.only(
          top: 2,
          bottom: 2,
          left: 8,
          right: 8 * 3,
        ),
        child: const Text(
          'Hoàn thành',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  @override
  buildActionButton(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  buildStatusBanner() {
    return Row(
      children: [
        const Text(
          "Thời gian: ",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          DateTimeUtils.orderTime(order.dateCreated),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
