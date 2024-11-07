import 'package:book_store_manager/utils/currency_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../models/order_product_model.dart';

class OrderDetailsProductItem extends StatelessWidget {
  final OrderProductModel product;

  const OrderDetailsProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          height: 50,
          width: 60,
          fit: BoxFit.contain,
          imageUrl: product.imgUrl,
        ),
        // Container(
        //   width: 50,
        //   height: 60,
        //   color: Colors.amber,
        // ),
        const Gap(8),
        Expanded(
          child: SizedBox(
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${CurrencyUtils.convertDoubleToCurrency(product.price)}đ",
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.2,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      "${CurrencyUtils.convertDoubleToCurrency(product.priceBPDiscount)}đ",
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.2,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'x${product.count.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.2,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
