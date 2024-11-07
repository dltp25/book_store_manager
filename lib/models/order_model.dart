import 'package:book_store_manager/models/order_product_model.dart';
import 'package:book_store_manager/utils/converter.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final String userName;
  final String phone;
  final String address;
  final String note;

  final DateTime dateCreated;
  final DateTime dateComplete;

  final String paymentMethod;
  final String transport;
  final int transportCode;

  final bool paid;
  final int status;
  final double totalPrice;
  final double transportPrice;
  final double productPrice;

  final List<OrderProductModel> products;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.userName,
    required this.phone,
    required this.address,
    required this.note,
    required this.dateCreated,
    required this.dateComplete,
    required this.paymentMethod,
    required this.transport,
    required this.paid,
    required this.status,
    required this.totalPrice,
    required this.transportPrice,
    required this.productPrice,
    required this.products,
    required this.transportCode,
  });

  factory OrderModel.fromJson(
      String id, Map<String, dynamic> json, List<OrderProductModel> products) {
    return OrderModel(
      orderId: id,
      userId: cvToString(json['userId']),
      userName: cvToString(json['userName']),
      phone: cvToString(json['phone']),
      address: cvToString(json['address']),
      note: cvToString(json['note']),
      dateCreated: cvToDate(json['dateCreated']),
      dateComplete: cvToDate(json['dateComplete']),
      paymentMethod: cvToString(json['paymentMethod']),
      transport: cvToString(json['transport']),
      transportCode: cvToInt(json['transportCode']),
      paid: cvToBool(json['paid']),
      status: cvToInt(json['status']),
      totalPrice: cvToDouble(json['totalPrice']),
      transportPrice: cvToDouble(json['transportPrice']),
      productPrice: cvToDouble(json['productPrice']),
      products: products,
    );
  }
}
