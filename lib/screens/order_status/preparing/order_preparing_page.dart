import 'package:book_store_manager/widgets/empty_orders_list.dart';
import 'package:book_store_manager/widgets/loading/loading_list.dart';
import 'bloc/preparing_order_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/abstract/preparing_order_item.dart';
import 'package:flutter/material.dart';

class OrderPreparingPage extends StatelessWidget {
  const OrderPreparingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreparingOrderBloc, PreparingOrderState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingList();
        }

        if (state.preparingOrders.isEmpty) {
          return const EmptyOrdersList();
        }

        return ListView.separated(
          itemCount: state.preparingOrders.length,
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
            return PreparingOrderItem(
              order: state.preparingOrders[index],
              onAction: () {
                context.read<PreparingOrderBloc>().add(
                      PreparingConfirmEvent(
                        orderId: state.preparingOrders[index].orderId,
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
