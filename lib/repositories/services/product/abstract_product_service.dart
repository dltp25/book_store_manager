import 'dart:io';

import '../../../models/product_create_model.dart';
import '../../../models/product_model.dart';

abstract class AbstractProductService {
  Future<List<ProductModel>> getAllProduct();

  Future<void> updateOverviewProduct({
    required String productId,
    required String title,
    required String author,
    required String publisher,
    required String publishingYear,
    required String type,
    required String description,
  });

  Future<ProductModel> getProduct(String productId);

  createNewProduct(ProductCreateModel product, List<File> imgs);

  Future<String> uploadFile(File image, String folderCode);

  Future<void> updatePriceAndDiscount(
      String productId, double price, double discount);

  Future<List<ProductLiteModel>> getAllLiteProduct();

  Future<void> importProduct(Map<ProductLiteModel, int> product);

  Future<void> addProductToInventory(String productId, int number);
}
