import 'package:book_store_manager/widgets/empty_orders_list.dart';
import 'package:book_store_manager/widgets/loading/loading_list.dart';

import '../bloc/user_order_history_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'order_creator.dart';
import 'package:flutter/material.dart';

class OrderHistoryList extends StatelessWidget {
  const OrderHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserOrderHistoryBloc, UserOrderHistoryState>(
      buildWhen: (previous, current) {
        return previous.isLoading != current.isLoading ||
            previous.showedOrders != current.showedOrders;
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingList();
        }

        if (state.showedOrders.isEmpty) {
          return const EmptyOrdersList();
        }

        return ListView.separated(
          itemCount: state.showedOrders.length,
          padding: const EdgeInsets.only(bottom: 4),
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[200],
              thickness: 4,
              height: 4,
            );
          },
          itemBuilder: (context, index) {
            return OrderCreator().createOrderItem(state.showedOrders[index]);
          },
        );
      },
    );
  }
}
