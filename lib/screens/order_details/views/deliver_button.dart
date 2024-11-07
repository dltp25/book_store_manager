import '../bloc/order_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../themes/colors.dart';
import '../../../widgets/dialogs/confirm_dialog.dart';

class DeliverButton extends StatelessWidget {
  final String orderId;
  const DeliverButton({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
            context.read<OrderDetailsBloc>().add(
                  DeliverConfirmOrderEvent(orderId: orderId),
                );
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themeColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: const Text(
        'Giao cho người vận chuyển',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
