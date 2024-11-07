import 'abstract_order_item.dart';
import 'package:flutter/material.dart';

import '../../utils/date_time.dart';
import '../flag_cllip_path.dart';

class CancelOrderItem extends AbstractOrderItem {
  const CancelOrderItem({super.key, required super.order});

  @override
  buildFlag() {
    return ClipPath(
      clipper: FlagClipPath(),
      child: Container(
        color: Colors.redAccent,
        padding: const EdgeInsets.only(
          top: 2,
          bottom: 2,
          left: 8,
          right: 8 * 3,
        ),
        child: const Text(
          'Đã hủy',
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
