import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/import_product_model.dart';
import '../../../models/product_model.dart';

abstract class AbstractImportService {
  Stream<QuerySnapshot<Map<String, dynamic>>> importHistoryStream(
      DateTime time);

  Future<List<ImportProductModel>> getInportHistory(DateTime time);

  Future<ProductLiteModel> getProductLiteInfor(String productId);

  Future<Map<ProductLiteModel, int>> getAllProductInImport(
      Map<String, dynamic> raw);

  Future<void> saveImportHistory(Map<ProductLiteModel, int> products);
}
