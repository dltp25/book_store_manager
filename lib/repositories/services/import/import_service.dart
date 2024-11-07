import 'package:book_store_manager/constant/data_collections.dart';
import 'package:book_store_manager/extensions/datetime_ex.dart';
import 'package:book_store_manager/models/import_product_model.dart';
import 'package:book_store_manager/models/product_model.dart';
import 'package:book_store_manager/repositories/services/import/abstract_import_service.dart';
import 'package:book_store_manager/utils/converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImportService extends AbstractImportService {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> importHistoryStream(
      DateTime time) {
    return FirebaseFirestore.instance
        .collection(DataCollection.import)
        .where('time', isGreaterThanOrEqualTo: time.startOfMonth())
        .where('time', isLessThanOrEqualTo: time.endOfMonth())
        .snapshots();
  }

  @override
  Future<List<ImportProductModel>> getInportHistory(DateTime time) async {
    List<ImportProductModel> result = [];
    final query = await FirebaseFirestore.instance
        .collection(DataCollection.import)
        .where('time', isGreaterThanOrEqualTo: time.startOfMonth())
        .where('time', isLessThanOrEqualTo: time.endOfMonth())
        .get();

    for (var ele in query.docs) {
      Map<String, int> products = ele.data()['products'];
      Map<ProductLiteModel, int> map = {};

      final futureGr = await Future.wait(
        products.entries.map((e) => getProductLiteInfor(e.key)),
      );

      for (int i = 0; i < products.length; i++) {
        map.addAll({futureGr[i]: cvToInt(products[futureGr[i].productId])});
      }

      result.add(ImportProductModel(
        id: ele.id,
        time: cvToDate(ele['time']),
        products: map,
      ));
    }

    return result;
  }

  @override
  Future<ProductLiteModel> getProductLiteInfor(String productId) async {
    final query = await FirebaseFirestore.instance
        .collection(DataCollection.book)
        .doc(productId)
        .get();
    return ProductLiteModel.fromJson(query.id, query.data()!);
  }

  @override
  Future<Map<ProductLiteModel, int>> getAllProductInImport(
      Map<String, dynamic> raw) async {
    Map<ProductLiteModel, int> res = {};

    final productsInfo = await Future.wait(
      raw.entries.map(
        (e) => getProductLiteInfor(e.key),
      ),
    );

    for (int i = 0; i < raw.entries.length; i++) {
      res.addAll(
        {
          productsInfo[i]: cvToInt(raw.values.elementAt(i)),
        },
      );
    }
    return res;
  }

  @override
  Future<void> saveImportHistory(Map<ProductLiteModel, int> products) async {
    Map<String, int> temp = {};
    for (var ele in products.entries) {
      temp.addAll({ele.key.productId: ele.value});
    }

    await FirebaseFirestore.instance.collection(DataCollection.import).add({
      'products': temp,
      'time': DateTime.now(),
    });
  }
}
