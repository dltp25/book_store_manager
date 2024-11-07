import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class DialogItem extends StatelessWidget {
  final ProductLiteModel productLite;
  final bool isSelected;

  const DialogItem({
    super.key,
    required this.productLite,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.grey[100]! : Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                fit: BoxFit.contain,
                opacity: isSelected ? 0.3 : 1,
                image: CachedNetworkImageProvider(
                  productLite.mainUrl,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${productLite.productName}\n",
                  style: TextStyle(
                    fontSize: 13,
                    color: isSelected ? Colors.grey[300] : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  'Hàng còn: ${productLite.stock.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
