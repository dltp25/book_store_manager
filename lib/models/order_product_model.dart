import 'package:book_store_manager/utils/converter.dart';

class OrderProductModel {
  final String productId;
  final String productName;
  final int count;
  final double price;
  final double priceBPDiscount;
  final String imgUrl;
  final String type;

  OrderProductModel({
    required this.productId,
    required this.productName,
    required this.count,
    required this.price,
    required this.priceBPDiscount,
    required this.imgUrl,
    required this.type,
  });

  factory OrderProductModel.fromJson(
      Map<String, dynamic> json, String name, String imgUrl, String type) {
    return OrderProductModel(
      productId: cvToString(json['productID']),
      productName: name,
      count: cvToInt(json['count']),
      price: cvToDouble(json['price']),
      priceBPDiscount: cvToDouble(json['priceBeforeDiscount']),
      imgUrl: imgUrl,
      type: type,
    );
  }
}
