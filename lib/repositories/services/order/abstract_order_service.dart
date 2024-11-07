import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/order_model.dart';
import '../../../models/order_product_model.dart';

abstract class AbstractOrderService {
  Stream<QuerySnapshot<Map<String, dynamic>>> ordersStream(int status);

  Stream<DocumentSnapshot<Map<String, dynamic>>> orderStream(String orderId);

  Stream<QuerySnapshot<Map<String, dynamic>>> userOrderStream(
      String userId, List<int> status);

  Future<Map<String, dynamic>> getProductInOrder(String productId);

  Future<void> confirmOrder(String orderId);

  Future<void> preparingConfirmOrder(String orderId);

  Future<void> preparedConfirmOrder(String orderId);

  Future<void> cancelOrder(String orderId);

  Future<List<OrderProductModel>> getAllProductInOrder(
      List<Map<String, dynamic>> productRaw);

  Future<List<OrderModel>> getUserDoneOrders(String userId);

  Future<List<OrderModel>> getDoneOrdersOfMonth(DateTime month);

  Future<OrderModel> getOrderInformation(String orderId);

  Future<List<OrderModel>> getAllOrdersOfMonth(DateTime month);
}
