import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../models/order_model.dart';
import '../../screens/order_details/order_details_page.dart';
import '../../themes/colors.dart';
import '../../utils/currency_utils.dart';
import '../../utils/date_time.dart';
import '../flag_cllip_path.dart';
import '../page_route_transition.dart';

abstract class AbstractOrderItem extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onAction;

  const AbstractOrderItem({
    super.key,
    required this.order,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteSlideTransition(
              child: OrderDetailsPage(orderId: order.orderId),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                buildFlag(),
                const Spacer(),
                buildStatusBanner(),
                const Gap(10),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Khách hàng: ",
                        style: TextStyle(fontSize: 12),
                      ),
                      Expanded(
                        child: Text(
                          order.userName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Gap(4),
                      Text(
                        " (${order.phone})",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Thời gian: ", style: TextStyle(fontSize: 12)),
                      Expanded(
                        child: Text(
                          DateTimeUtils.orderTime(order.dateCreated),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Vận chuyển: ",
                        style: TextStyle(fontSize: 12),
                      ),
                      Expanded(
                        child: Text(
                          order.transport,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Sản phẩm (${order.products.length.toStringAsFixed(0)}): ",
                    style: const TextStyle(fontSize: 12),
                  ),
                  const Gap(4),
                  SizedBox(
                    height: 48,
                    child: ListView.separated(
                      itemCount:
                          order.products.length > 6 ? 6 : order.products.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 4);
                      },
                      itemBuilder: (context, index) {
                        if (index == 5 && order.products.length > 6) {
                          return Container(
                            width: 48,
                            height: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[200]!),
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                opacity: 0.2,
                                image: CachedNetworkImageProvider(
                                  order.products[index].imgUrl,
                                ),
                              ),
                            ),
                            child: Text(
                              "+${(order.products.length - 5).toStringAsFixed(0)}",
                            ),
                          );
                        }

                        return Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[200]!),
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: CachedNetworkImageProvider(
                                order.products[index].imgUrl,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: AppColors.themeColor.withOpacity(0.6),
              height: 8,
              indent: 8,
              endIndent: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      maxLines: 1,
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Tổng đơn: ',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                "${CurrencyUtils.convertDoubleToCurrency(order.totalPrice)}đ",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(4),
                  buildActionButton(context),
                ],
              ),
            ),
            const Gap(4),
          ],
        ),
      ),
    );
  }

  buildFlag() {
    return ClipPath(
      clipper: FlagClipPath(),
      child: Container(
        color: order.paid ? Colors.blue[300] : Colors.red[400],
        padding: const EdgeInsets.only(
          top: 2,
          bottom: 2,
          left: 8,
          right: 8 * 3,
        ),
        child: Text(
          order.paid ? 'Đã thanh toán' : 'Chưa thanh toán',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  buildStatusBanner();

  buildActionButton(BuildContext context);
}
