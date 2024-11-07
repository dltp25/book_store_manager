import 'abstract_order_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../themes/colors.dart';
import '../dialogs/confirm_dialog.dart';

class PreparingOrderItem extends AbstractOrderItem {
  const PreparingOrderItem({
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
                      'Xác nhận chuẩn bị xong đơn hàng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Gap(12),
                    Text(
                      'Tiếp tục sẽ chuyển đơn hàng sang trạng thái chờ lấy hàng',
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
          'Chuẩn bị xong',
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }

  @override
  buildStatusBanner() {
    return Text(
      'Đang chuẩn bị',
      style: TextStyle(
        color: AppColors.themeColor,
        fontSize: 12,
      ),
    );
  }
}
