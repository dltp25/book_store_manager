import 'package:book_store_manager/themes/colors.dart';
import 'abstract_order_item.dart';
import 'package:flutter/material.dart';

class DeliveringOrderItem extends AbstractOrderItem {
  const DeliveringOrderItem({
    super.key,
    required super.order,
  });

  @override
  buildActionButton(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor.withOpacity(0.8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: const Text(
          'Đang giao',
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }

  @override
  buildStatusBanner() {
    return Text(
      'Đang giao hàng',
      style: TextStyle(
        color: AppColors.themeColor,
        fontSize: 12,
      ),
    );
  }
}
