import 'package:book_store_manager/widgets/empty_orders_list.dart';
import 'package:book_store_manager/widgets/loading/loading_list.dart';

import 'bloc/delivering_order_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/abstract/delivering_order_item.dart';
import 'package:flutter/material.dart';

class OrderDeliveringPage extends StatelessWidget {
  const OrderDeliveringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveringOrderBloc, DeliveringOrderState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingList();
        }

        if (state.deliveringOrders.isEmpty) {
          return const EmptyOrdersList();
        }

        return ListView.separated(
          itemCount: state.deliveringOrders.length,
          padding: const EdgeInsets.symmetric(vertical: 4),
          physics: const ClampingScrollPhysics(),
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[200],
              thickness: 4,
              height: 4,
            );
          },
          itemBuilder: (context, index) {
            return DeliveringOrderItem(
              order: state.deliveringOrders[index],
            );
          },
        );
      },
    );
  }
}
