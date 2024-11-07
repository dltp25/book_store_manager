import 'package:book_store_manager/themes/colors.dart';
import 'abstract_order_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../dialogs/confirm_dialog.dart';

class PreparedOrderItem extends AbstractOrderItem {
  const PreparedOrderItem({
    super.key,
    required super.order,
    required super.onAction,
  });

  @override
  buildActionButton(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const ConfirmDialog(
                cancelString: 'Thoát',
                confirmString: 'Xác nhận',
                child: Column(
                  children: [
                    Text(
                      'Bắt đầu giao hàng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Gap(12),
                    Text(
                      'Đơn hàng từ giờ sẽ được vận chuyển đến người mua, bạn sẽ không thể thay đổi đơn hàng',
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                    Gap(12),
                  ],
                ),
              );
            },
          ).then((value) {
            if (value == true) {
              onAction!();
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor.withOpacity(0.8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: const Text(
          'Giao hàng',
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }

  @override
  buildStatusBanner() {
    return Text(
      'Chờ lấy hàng',
      style: TextStyle(
        color: AppColors.themeColor,
        fontSize: 12,
      ),
    );
  }
}
