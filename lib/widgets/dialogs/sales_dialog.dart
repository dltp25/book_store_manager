import 'package:book_store_manager/models/book_type_model.dart';
import 'package:book_store_manager/models/order_model.dart';
import 'package:book_store_manager/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../models/order_product_model.dart';

class SalesDialog extends StatelessWidget {
  final List<OrderModel> orders;
  final DateTime selectedMonth;

  const SalesDialog({
    super.key,
    required this.orders,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    Map<OrderProductModel, int> counter = countProductsInOrders(orders);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.8,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding:
              const EdgeInsets.only(top: 10, bottom: 16, left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Doanh số tháng ${DateTimeUtils.monthYearString(selectedMonth)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Gap(12),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1),
                        },
                        children: [
                          const TableRow(
                            children: [
                              SizedBox(
                                height: 32,
                                child: Center(
                                  child: Text(
                                    'Thể loại',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 32,
                                child: Center(
                                  child: Text(
                                    'Bán được',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ...BookTypesModel.codeToDes.entries.map(
                            (e) => TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    e.value,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 4,
                                  ),
                                  child: Center(
                                    child: Text(
                                      countType(counter, e.key)
                                          .toStringAsFixed(0),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 4,
                                ),
                                child: Text(
                                  'Tổng',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 4,
                                ),
                                child: Center(
                                  child: Text(
                                    counter.values
                                        .reduce((value, element) =>
                                            value += element)
                                        .toStringAsFixed(0),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Gap(12),
                      const Text(
                        'Chi tiết',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const Gap(4),
                      Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(9),
                          1: FlexColumnWidth(2),
                        },
                        children: [
                          const TableRow(
                            children: [
                              SizedBox(
                                height: 32,
                                child: Center(
                                  child: Text(
                                    'Sản phẩm',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 32,
                                child: Center(
                                  child: Text(
                                    'SL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ...counter.entries.map(
                            (e) => TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    "${e.key.productName}\n",
                                    maxLines: 2,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 4,
                                  ),
                                  child: Center(
                                    child: Text(
                                      e.value.toStringAsFixed(0),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int countType(Map<OrderProductModel, int> products, String type) {
    int res = 0;
    for (var ele in products.entries) {
      if (ele.key.type == type) {
        res += ele.value;
      }
    }
    return res;
  }

  Map<OrderProductModel, int> countProductsInOrders(List<OrderModel> orders) {
    Map<OrderProductModel, int> productCounts = {};

    for (OrderModel order in orders) {
      for (OrderProductModel product in order.products) {
        if (productCounts.containsKey(product.productId)) {
          productCounts[product] =
              (productCounts[product] ?? 0) + product.count;
        } else {
          productCounts[product] = product.count;
        }
      }
    }

    List<MapEntry<OrderProductModel, int>> sortedEntries =
        productCounts.entries.toList();
    sortedEntries.sort((a, b) => b.value.compareTo(a.value));
    Map<OrderProductModel, int> sortedProductCounts =
        Map.fromEntries(sortedEntries);

    return sortedProductCounts;
  }
}
