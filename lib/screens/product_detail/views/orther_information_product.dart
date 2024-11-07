import 'update_orther_infor_dialog.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../bloc/product_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/currency_utils.dart';
import '../../../widgets/data_form.dart';
import '../../../widgets/title.dart';
import 'row_data.dart';

class OrderInformationProduct extends StatelessWidget {
  const OrderInformationProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return DataForm(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Column(
              children: [
                Row(
                  children: [
                    const MyTitle(
                      text: 'Thông tin khác',
                      padding: EdgeInsets.zero,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Row(
                        children: [
                          Text(
                            'Chỉnh sửa ',
                            style: TextStyle(fontSize: 12),
                          ),
                          Icon(Icons.edit_square, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.orangeAccent[700]!,
                    size: 40,
                  ),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const MyTitle(
                    text: 'Thông tin khác',
                    padding: EdgeInsets.zero,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return UpdateOrtherInforDialog(
                            discount: state.productData!.discount,
                            price: state.productData!.price,
                          );
                        },
                      ).then((value) {
                        if (value != null) {
                          value as Map<String, double>;

                          context.read<ProductDetailBloc>().add(
                                UpdatePriceAndDiscountEvent(
                                  price: value['price']!,
                                  discount: value['discount']!,
                                ),
                              );
                        }
                      });
                    },
                    icon: const Row(
                      children: [
                        Text(
                          'Chỉnh sửa ',
                          style: TextStyle(fontSize: 12),
                        ),
                        Icon(Icons.edit_square, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
              RowData(
                title: 'Giá bán',
                content:
                    '${CurrencyUtils.convertDoubleToCurrency(state.productData!.price)}đ',
                spaceBetween: true,
                padding: const EdgeInsets.only(bottom: 2),
                contentStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              RowData(
                title: 'Giảm giá',
                content:
                    "${(state.productData!.discount * 100).toStringAsFixed(0)}%",
                spaceBetween: true,
                contentStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              RowData(
                title: 'Số lượt bán',
                content: "${state.productData!.totalSold}",
                spaceBetween: true,
                contentStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
