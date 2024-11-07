import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order_model.dart';
import '../models/order_product_model.dart';
import 'services/order/abstract_order_service.dart';
import 'services/order/order_service.dart';
import 'services/transaction/abstract_transaction_service.dart';
import 'services/transaction/transaction_service.dart';

import '../models/home_statistic_model.dart';

class OrderRepository {
  late AbstractOrderService _orderService;
  late AbstractTransactionService _transactionService;

  OrderRepository() {
    _orderService = OrderService();
    _transactionService = TransactionService();
  }

  Future<HomeStatisticModel> getMonthStatistic(DateTime dateTime) async {
    return _transactionService.getMonthStatistic(dateTime);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> ordersStream(int status) {
    return _orderService.ordersStream(status);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> orderStream(String orderId) {
    return _orderService.orderStream(orderId);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userOrderStream(
      String userId, List<int> status) {
    return _orderService.userOrderStream(userId, status);
  }

  Future<Map<String, dynamic>> getProductInOrder(String productId) async {
    return _orderService.getProductInOrder(productId);
  }

  Future<void> confirmOrder(String orderId) async {
    return _orderService.confirmOrder(orderId);
  }

  Future<void> preparingConfirmOrder(String orderId) async {
    return _orderService.preparingConfirmOrder(orderId);
  }

  Future<void> preparedConfirmOrder(String orderId) async {
    return _orderService.preparedConfirmOrder(orderId);
  }

  Future<void> cancelOrder(String orderId) async {
    return _orderService.cancelOrder(orderId);
  }

  Future<List<OrderProductModel>> getAllProductInOrder(
      List<Map<String, dynamic>> productRaw) async {
    return _orderService.getAllProductInOrder(productRaw);
  }

  Future<List<OrderModel>> getUserDoneOrders(String userId) async {
    return _orderService.getUserDoneOrders(userId);
  }

  Future<List<OrderModel>> getDoneOrdersOfMonth(DateTime month) async {
    return _orderService.getDoneOrdersOfMonth(month);
  }

  Future<List<OrderModel>> getAllOrdersOfMonth(DateTime month) async {
    return _orderService.getAllOrdersOfMonth(month);
  }

  Future<OrderModel> getOrderInformation(String orderId) async {
    return _orderService.getOrderInformation(orderId);
  }
}
