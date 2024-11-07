import 'package:book_store_manager/models/product_model.dart';
import 'package:book_store_manager/widgets/dialogs/confirm_dialog.dart';
import 'package:gap/gap.dart';

import '../bloc/product_edit_overview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes/colors.dart';

class ConfirmUpdateButton extends StatelessWidget {
  final ProductModel product;

  const ConfirmUpdateButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 44,
        child: BlocBuilder<ProductEditOverviewBloc, ProductEditOverviewState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const SizedBox.shrink();
            }

            return ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ConfirmDialog(
                      cancelString: 'Hủy',
                      confirmString: 'Cập nhật',
                      child: Column(
                        children: [
                          const Text(
                            'Cập nhật thông tin sản phẩm',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Gap(12),
                          Text.rich(
                            TextSpan(
                              text:
                                  'Bạn xác nhận muốn cập nhật thông tin cho sản phẩm: ',
                              children: [
                                TextSpan(
                                  text: product.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(),
                          ),
                          const Gap(12),
                        ],
                      ),
                    );
                  },
                ).then((value) {
                  if (value == true) {
                    context.read<ProductEditOverviewBloc>().add(
                          ConfirmUpdateEvent(),
                        );
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.themeColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cập nhật',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
