import 'package:book_store_manager/repositories/services/import/import_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/import_product_model.dart';
import '../models/product_model.dart';
import 'services/import/abstract_import_service.dart';

class ImportRepository {
  late AbstractImportService _importService;

  ImportRepository() {
    _importService = ImportService();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> importHistoryStream(
      DateTime time) {
    return _importService.importHistoryStream(time);
  }

  Future<List<ImportProductModel>> getInportHistory(DateTime time) async {
    return _importService.getInportHistory(time);
  }

  Future<Map<ProductLiteModel, int>> getAllProductInImport(
      Map<String, dynamic> raw) async {
    return _importService.getAllProductInImport(raw);
  }

  Future<void> saveImportHistory(Map<ProductLiteModel, int> products) async {
    return _importService.saveImportHistory(products);
  }
}
