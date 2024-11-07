import 'order_creator.dart';
import 'package:book_store_manager/widgets/empty_orders_list.dart';

import '../../../widgets/loading/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/order_done_bloc.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDoneBloc, OrderDoneState>(
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
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[200],
              thickness: 4,
              height: 4,
            );
          },
          itemBuilder: (context, index) {
            return DoneOrderCreator()
                .createOrderItem(state.showedOrders[index]);
          },
        );
      },
    );
  }
}
