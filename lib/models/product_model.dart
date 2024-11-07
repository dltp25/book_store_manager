import 'package:book_store_manager/utils/converter.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final String author;
  final String type;
  final String publisher;
  final String publishingYear;
  final String searchKey;

  final double price;
  final double discount;
  final int stock;
  final int totalSold;

  final List<String> allImages;
  final List<String> showImages;
  final String mainImage;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.type,
    required this.publisher,
    required this.publishingYear,
    required this.price,
    required this.discount,
    required this.allImages,
    required this.showImages,
    required this.mainImage,
    required this.searchKey,
    required this.stock,
    required this.totalSold,
  });

  factory ProductModel.fromJson(String id, Map<String, dynamic> json) {
    List<String> img = List.from(json['listURL']);
    List<String> showImg = List.from(json['showedURL']);

    return ProductModel(
      id: id,
      title: cvToString(json['title']),
      description: cvToString(json['description']),
      author: cvToString(json['author']),
      type: cvToString(json['type']),
      publisher: cvToString(json['publisher']),
      publishingYear: cvToString(json['publishingYear']),
      price: cvToDouble(json['price']),
      discount: cvToDouble(json['discount']),
      allImages: img,
      showImages: showImg,
      mainImage: cvToString(json['mainURL']),
      searchKey: cvToString(json['searchKey']),
      stock: cvToInt(json['stock']),
      totalSold: cvToInt(json['totalSold']),
    );
  }
}

class ProductLiteModel {
  final String productId;
  final String productName;
  final String mainUrl;
  final int stock;

  ProductLiteModel({
    required this.productId,
    required this.productName,
    required this.mainUrl,
    required this.stock,
  });

  factory ProductLiteModel.fromJson(String id, Map<String, dynamic> json) {
    return ProductLiteModel(
      productId: id,
      productName: cvToString(json['title']),
      mainUrl: cvToString(json['mainURL']),
      stock: cvToInt(json['stock']),
    );
  }
}
