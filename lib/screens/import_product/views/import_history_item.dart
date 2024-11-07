import 'package:book_store_manager/models/import_product_model.dart';
import 'package:book_store_manager/screens/import_product/import_product_detail.dart';
import 'package:book_store_manager/utils/date_time.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../models/product_model.dart';

class ImportHistoryItem extends StatelessWidget {
  final ImportProductModel importProductModel;
  const ImportHistoryItem({super.key, required this.importProductModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteSlideTransition(
            child: ImportProductDetail(importModel: importProductModel),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Mã đơn: ', style: TextStyle(fontSize: 12)),
                Text(
                  importProductModel.id,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Text('Thời gian: ', style: TextStyle(fontSize: 12)),
                Text(
                  DateTimeUtils.importTime(importProductModel.time),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Số loại sản phẩm: ',
                    style: TextStyle(fontSize: 12)),
                Text(
                  importProductModel.products.length.toStringAsFixed(0),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Tổng số lượng: ', style: TextStyle(fontSize: 12)),
                Text(
                  calculateTotal(importProductModel.products)
                      .toStringAsFixed(0),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Gap(4),
            SizedBox(
              height: 48,
              child: ListView.separated(
                itemCount: importProductModel.products.length > 6
                    ? 6
                    : importProductModel.products.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 4);
                },
                itemBuilder: (context, index) {
                  if (index == 5 && importProductModel.products.length > 6) {
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
                            importProductModel.products.keys
                                .elementAt(index)
                                .mainUrl,
                          ),
                        ),
                      ),
                      child: Text(
                        "+${(importProductModel.products.length - 5).toStringAsFixed(0)}",
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
                          importProductModel.products.keys
                              .elementAt(index)
                              .mainUrl,
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
    );
  }

  int calculateTotal(Map<ProductLiteModel, int> products) {
    int total = 0;
    for (var ele in products.entries) {
      total += ele.value;
    }
    return total;
  }
}
