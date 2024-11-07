import 'package:book_store_manager/models/order_model.dart';
import 'package:book_store_manager/widgets/dialogs/warning_dialog.dart';

import '../bloc/order_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../themes/colors.dart';
import '../../../widgets/dialogs/confirm_dialog.dart';

class ConfirmOrderButton extends StatelessWidget {
  final OrderModel order;
  const ConfirmOrderButton({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (order.paid) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const WarningDialog(
                      cancelString: 'Thoát',
                      child: Column(
                        children: [
                          Text(
                            'Hủy đơn thất bại',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Gap(12),
                          Text(
                            'Không thể hủy đơn hàng đã thanh toán',
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                          Gap(12),
                        ],
                      ),
                    );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const ConfirmDialog(
                      cancelString: 'Thoát',
                      confirmString: 'Hủy đơn',
                      child: Column(
                        children: [
                          Text(
                            'Hủy đơn hàng',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Gap(12),
                          Text(
                            'Xác nhận hủy đơn hàng?',
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
                    context.read<OrderDetailsBloc>().add(
                          CancelOrderEvent(orderId: order.orderId),
                        );
                  }
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(
                  color: AppColors.themeColor,
                  width: 1,
                ),
              ),
            ),
            child: Text(
              'Hủy đơn',
              style: TextStyle(
                color: AppColors.themeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const Gap(6),
        Expanded(
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
                  context.read<OrderDetailsBloc>().add(
                        ConfirmOrderEvent(orderId: order.orderId),
                      );
                }
              });
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.themeColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              'Xác nhận đơn',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
