import 'views/import_detail_item.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/utils/date_time.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constant/app_icons.dart';
import '../../models/import_product_model.dart';
import '../../models/product_model.dart';

class ImportProductDetail extends StatelessWidget {
  final ImportProductModel importModel;

  const ImportProductDetail({super.key, required this.importModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Chi tiết đơn nhập',
        color: Colors.orangeAccent[700]!,
        imgBg: AppIcons.add,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông tin đơn nhập',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mã đơn',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        importModel.id,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Thời gian',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        DateTimeUtils.importTime(importModel.time),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Số loại sản phẩm',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        '${importModel.products.length.toStringAsFixed(0)} loại',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tổng số lượng',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        calculateTotal(importModel.products).toStringAsFixed(0),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Sản phẩm',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: importModel.products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ImportDetailItem(
                        product: importModel.products.keys.elementAt(index),
                        quantity: importModel.products.values.elementAt(index),
                      );
                    },
                  ),
                ],
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
