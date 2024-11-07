import '../../../widgets/empty_orders_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/loading/loading_list.dart';
import '../bloc/manage_order_bloc.dart';
import 'orders_list.dart';

class FastOrders extends StatelessWidget {
  const FastOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageOrderBloc, ManageOrderState>(
      buildWhen: (previous, current) {
        return previous.fastOrders != current.fastOrders ||
            previous.isLoading != current.isLoading;
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingList();
        }

        if (state.fastOrders.isEmpty) {
          return const EmptyOrdersList();
        }

        return OrdersList(orders: state.fastOrders);
      },
    );
  }
}
