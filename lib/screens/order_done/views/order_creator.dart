import 'package:book_store_manager/models/order_model.dart';
import 'package:book_store_manager/widgets/abstract/abstract_order_item.dart';
import 'package:book_store_manager/widgets/abstract/cancel_order_item.dart';
import 'package:book_store_manager/widgets/abstract/complete_order_item.dart';

class DoneOrderCreator {
  AbstractOrderItem createOrderItem(OrderModel order) {
    if (order.status == -1) {
      return CancelOrderItem(order: order);
    }

    return CompleteOrderItem(order: order);
  }
}
