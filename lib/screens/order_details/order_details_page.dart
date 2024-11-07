import 'package:book_store_manager/repositories/repository.dart';
import 'views/order_status.dart';
import 'views/overview_information.dart';
import 'views/deliver_button.dart';
import 'views/prepare_button.dart';
import 'views/confirm_button.dart';
import 'package:book_store_manager/utils/currency_utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../models/order_product_model.dart';
import 'bloc/order_details_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'views/product_item.dart';
import 'package:gap/gap.dart';

import 'views/row_info_space.dart';
import 'package:book_store_manager/widgets/data_form.dart';
import 'package:flutter/material.dart';

import '../../constant/app_icons.dart';
import '../../themes/colors.dart';
import '../../widgets/custom_app_bar.dart';

class OrderDetailsPage extends StatelessWidget {
  // final OrderModel orderData;
  final String orderId;

  const OrderDetailsPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDetailsBloc(
        RepositoryProvider.of<AppRepository>(context).orderRepository,
      )..add(InitialDetailEvent(orderId: orderId)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: 'Chi tiết đơn hàng',
          imgBg: AppIcons.orderFill,
          color: Colors.orangeAccent[700]!,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DataForm(
                  child: Column(
                children: [
                  OrderDetailsOverview(),
                  OrderStatus(),
                ],
              )),
              DataForm(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
                      builder: (context, state) {
                        return Text(
                          state.orderData != null
                              ? 'Sản phẩm (${state.orderData!.products.length.toStringAsFixed(0)})'
                              : "Sản phẩm",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        );
                      },
                    ),
                    const Gap(10),
                    BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
                      builder: (context, state) {
                        return ListView.separated(
                          itemCount: state.orderData != null
                              ? state.orderData!.products.length
                              : 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return Divider(color: Colors.grey[300], height: 10);
                          },
                          itemBuilder: (context, index) {
                            return OrderDetailsProductItem(
                              product: state.orderData!.products[index],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              DataForm(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Thành tiền',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Gap(6),
                    BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
                      builder: (context, state) {
                        return OrderDetailsRowInfoSpace(
                          title: 'Phí vận chuyển',
                          content: state.orderData != null
                              ? "${CurrencyUtils.convertDoubleToCurrency(state.orderData!.transportPrice)}đ"
                              : null,
                        );
                      },
                    ),
                    BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
                      builder: (context, state) {
                        return OrderDetailsRowInfoSpace(
                          title: 'Sản phẩm',
                          content: state.orderData != null
                              ? "${CurrencyUtils.convertDoubleToCurrency(productPrice(state.orderData!.products))}đ"
                              : null,
                        );
                      },
                    ),
                    BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
                      builder: (context, state) {
                        return OrderDetailsRowInfoSpace(
                          title: 'Giảm',
                          content: state.orderData != null
                              ? "${CurrencyUtils.convertDoubleToCurrency(productPrice(state.orderData!.products) - state.orderData!.productPrice)}đ"
                              : null,
                        );
                      },
                    ),
                    Divider(color: Colors.grey[300]!),
                    Row(
                      children: [
                        const Text(
                          "Tổng đơn: ",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Expanded(
                          child:
                              BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
                            builder: (context, state) {
                              return Text(
                                state.orderData != null
                                    ? "${CurrencyUtils.convertDoubleToCurrency(state.orderData!.totalPrice)}đ"
                                    : '-/-',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 6,
                  right: 6,
                  bottom: MediaQuery.of(context).padding.bottom + 10,
                  top: 4,
                ),
                child: SizedBox(
                  height: 44,
                  width: double.infinity,
                  child: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        );
                      }

                      if (state.status == -1) {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: const Text(
                            'Đơn hàng đã bị hủy',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      if (state.status == 0) {
                        return ConfirmOrderButton(order: state.orderData!);
                      }

                      if (state.status == 1) {
                        return PrepareOrderButton(orderId: orderId);
                      }

                      if (state.status == 2) {
                        return DeliverButton(orderId: orderId);
                      }

                      if (state.status == 3) {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: const Text(
                            'Đơn hàng đang được vận chuyển',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      if (state.status == 4) {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Đơn hàng đã được giao thành công',
                                style: TextStyle(color: Colors.white),
                              ),
                              Gap(4),
                              Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            ],
                          ),
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double productPrice(List<OrderProductModel> products) {
    double total = 0;
    for (var ele in products) {
      total += ele.count * ele.priceBPDiscount;
    }
    return total;
  }
}
