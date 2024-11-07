import 'package:book_store_manager/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductInformation extends StatelessWidget {
  final ProductModel product;

  const ProductInformation({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 72,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: CachedNetworkImageProvider(product.mainImage),
              ),
            ),
          ),
          Expanded(
            child: Text(
              product.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
