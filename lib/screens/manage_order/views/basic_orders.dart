import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/loading/loading_list.dart';
import '../bloc/manage_order_bloc.dart';
import '../../../widgets/empty_orders_list.dart';
import 'orders_list.dart';

class BasicOrders extends StatelessWidget {
  const BasicOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageOrderBloc, ManageOrderState>(
      buildWhen: (previous, current) {
        return previous.basicOrders != current.basicOrders ||
            previous.isLoading != current.isLoading;
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingList();
        }

        if (state.basicOrders.isEmpty) {
          return const EmptyOrdersList();
        }

        return OrdersList(orders: state.basicOrders);
      },
    );
  }
}
