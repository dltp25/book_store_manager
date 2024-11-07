import 'package:book_store_manager/models/order_model.dart';
import 'package:book_store_manager/widgets/abstract/await_confirm_order_item.dart';
import 'package:book_store_manager/widgets/abstract/delivering_order_item.dart';
import 'package:book_store_manager/widgets/abstract/prepared_order_item.dart';
import 'package:book_store_manager/widgets/abstract/preparing_order_item.dart';
import 'package:book_store_manager/screens/user_details/bloc/user_details_bloc.dart';
import 'package:book_store_manager/widgets/abstract/abstract_order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrderItemCreator {
  AbstractOrderItem createOrderItem(BuildContext context, OrderModel order) {
    switch (order.status) {
      case 0:
        return AwaitConfirmOrderItem(
          order: order,
          onAction: () {
            context.read<UserDetailsBloc>().add(
                  ConfirmOrderEvent(orderId: order.orderId),
                );
          },
        );
      case 1:
        return PreparingOrderItem(
          order: order,
          onAction: () {
            context.read<UserDetailsBloc>().add(
                  PreparingConfirmOrderEvent(orderId: order.orderId),
                );
          },
        );
      case 2:
        return PreparedOrderItem(
          order: order,
          onAction: () {
            context.read<UserDetailsBloc>().add(
                  PreparedConfirmOrderEvent(orderId: order.orderId),
                );
          },
        );
      case 3:
        return DeliveringOrderItem(order: order);
      default:
        throw Exception('Unhandled status');
    }
  }
}
