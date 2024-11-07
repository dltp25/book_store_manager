import 'orders_list.dart';

import '../bloc/manage_order_bloc.dart';
import '../../../widgets/loading/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/empty_orders_list.dart';

class ExpressOrders extends StatelessWidget {
  const ExpressOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageOrderBloc, ManageOrderState>(
      buildWhen: (previous, current) {
        return previous.expressOrders != current.expressOrders ||
            previous.isLoading != current.isLoading;
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingList();
        }

        if (state.expressOrders.isEmpty) {
          return const EmptyOrdersList();
        }

        return OrdersList(orders: state.expressOrders);
      },
    );
  }
}
