import 'dart:io';

import 'package:book_store_manager/constant/data_collections.dart';
import 'package:book_store_manager/models/product_create_model.dart';
import 'package:book_store_manager/models/product_model.dart';
import 'package:book_store_manager/utils/converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'abstract_product_service.dart';

class ProductService extends AbstractProductService {
  @override
  Future<List<ProductModel>> getAllProduct() async {
    List<ProductModel> res = [];

    final query =
        await FirebaseFirestore.instance.collection(DataCollection.book).get();
    for (var ele in query.docs) {
      res.add(ProductModel.fromJson(ele.id, ele.data()));
    }

    return res;
  }

  @override
  Future<void> updateOverviewProduct({
    required String productId,
    required String title,
    required String author,
    required String publisher,
    required String publishingYear,
    required String type,
    required String description,
  }) async {
    final ref = FirebaseFirestore.instance
        .collection(DataCollection.book)
        .doc(productId);

    await ref.set({
      'title': title,
      'author': author,
      'publisher': publisher,
      'publishingYear': publishingYear,
      'type': type,
      'description': description,
    }, SetOptions(merge: true));
  }

  @override
  Future<ProductModel> getProduct(String productId) async {
    final query = await FirebaseFirestore.instance
        .collection(DataCollection.book)
        .doc(productId)
        .get();

    return ProductModel.fromJson(query.id, query.data()!);
  }

  @override
  createNewProduct(ProductCreateModel product, List<File> imgs) async {
    DateTime createTime = DateTime.now();
    int createCode = Timestamp.fromDate(createTime).seconds;

    final imgUrls = await Future.wait(
      imgs.map((e) => uploadFile(e, createCode.toString())),
    );

    final ref = FirebaseFirestore.instance.collection(DataCollection.book);
    Map<String, dynamic> data = product.toJson();
    String searchKey =
        '${removeDiacritics(product.title.toLowerCase())} ${removeDiacritics(product.author.toLowerCase())}';

    data.addAll({
      'star': 0,
      'totalSold': 0,
      'mainURL': imgUrls[0],
      'showedURL': imgUrls,
      'listURL': imgUrls,
      'searchKey': searchKey,
      'images': 'book_$createCode',
    });

    await ref.add(data);
  }

  @override
  Future<String> uploadFile(File image, String folderCode) async {
    final storageReference = FirebaseStorage.instance
        .ref()
        .child('Book/book_$folderCode/${image.path.split('/').last}');

    await storageReference.putFile(image);
    return storageReference.getDownloadURL();
  }

  @override
  Future<void> updatePriceAndDiscount(
      String productId, double price, double discount) async {
    final docRef = FirebaseFirestore.instance
        .collection(DataCollection.book)
        .doc(productId);

    await docRef.update({
      'price': price,
      'discount': discount,
    });
  }

  @override
  Future<List<ProductLiteModel>> getAllLiteProduct() async {
    List<ProductLiteModel> res = [];

    final query =
        await FirebaseFirestore.instance.collection(DataCollection.book).get();
    for (var ele in query.docs) {
      res.add(ProductLiteModel.fromJson(ele.id, ele.data()));
    }

    return res;
  }

  @override
  Future<void> importProduct(Map<ProductLiteModel, int> product) async {
    await Future.wait(
      product.entries.map(
        (e) => addProductToInventory(e.key.productId, e.value),
      ),
    );
  }

  @override
  Future<void> addProductToInventory(String productId, int number) async {
    final docRef = FirebaseFirestore.instance
        .collection(DataCollection.book)
        .doc(productId);

    final data = await docRef.get();

    int currentQuantity = cvToInt(data.data()?['stock']);
    int newQuantity = currentQuantity + number;

    await docRef.set({'stock': newQuantity}, SetOptions(merge: true));
  }
}
