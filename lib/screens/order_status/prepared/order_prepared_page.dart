import 'bloc/prepared_order_bloc.dart';
import 'package:book_store_manager/widgets/empty_orders_list.dart';
import 'package:book_store_manager/widgets/loading/loading_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/abstract/prepared_order_item.dart';
import 'package:flutter/material.dart';

class OrderPreparedPage extends StatelessWidget {
  const OrderPreparedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreparedOrderBloc, PreparedOrderState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingList();
        }

        if (state.preparedOrders.isEmpty) {
          return const EmptyOrdersList();
        }

        return ListView.separated(
          itemCount: state.preparedOrders.length,
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
            return PreparedOrderItem(
              order: state.preparedOrders[index],
              onAction: () {
                context.read<PreparedOrderBloc>().add(
                      PreparedConfirmEvent(
                        orderId: state.preparedOrders[index].orderId,
                      ),
                    );
              },
            );
          },
        );
      },
    );
  }
}
