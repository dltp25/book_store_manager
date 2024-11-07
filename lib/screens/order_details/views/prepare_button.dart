import '../bloc/order_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../themes/colors.dart';
import '../../../widgets/dialogs/confirm_dialog.dart';

class PrepareOrderButton extends StatelessWidget {
  final String orderId;
  const PrepareOrderButton({super.key, required this.orderId});

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
            context.read<OrderDetailsBloc>().add(
                  PrepareConfirmOrderEvent(orderId: orderId),
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
        'Chuẩn bị đơn xong',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
