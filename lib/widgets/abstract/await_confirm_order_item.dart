import 'abstract_order_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../themes/colors.dart';
import '../dialogs/confirm_dialog.dart';

class AwaitConfirmOrderItem extends AbstractOrderItem {
  const AwaitConfirmOrderItem({
    super.key,
    required super.order,
    required super.onAction,
  });

  @override
  buildStatusBanner() {
    return Text(
      'Chờ xác nhận',
      style: TextStyle(
        color: AppColors.themeColor,
        fontSize: 12,
      ),
    );
  }

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
                      'Xác nhận đơn hàng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Gap(12),
                    Text(
                      'Đơn hàng sẽ được chuyển sang trạng thái đang chuẩn bị',
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                    Gap(12),
                  ],
                ),
              );
            },
          ).then((value) {
            if (value != null && value == true) {
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
          'Xác nhận',
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}
