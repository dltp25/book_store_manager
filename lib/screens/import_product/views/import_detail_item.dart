import 'package:book_store_manager/models/product_model.dart';
import 'package:book_store_manager/screens/product_detail/product_detail_page.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ImportDetailItem extends StatelessWidget {
  final ProductLiteModel product;
  final int quantity;

  const ImportDetailItem({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteSlideTransition(
            child: ProductDetailPage(productId: product.productId)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(product.mainUrl),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.productName}\n',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      const Text(
                        'Số lượng: ',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        quantity.toStringAsFixed(0),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
