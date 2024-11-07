import 'package:book_store_manager/models/product_model.dart';

class ImportProductModel {
  final String id;
  final DateTime time;
  final Map<ProductLiteModel, int> products;

  ImportProductModel({
    required this.id,
    required this.time,
    required this.products,
  });
}
