import 'user_order_item_creator.dart';
import 'package:book_store_manager/widgets/empty_orders_list.dart';

import "../bloc/user_details_bloc.dart";
import 'package:book_store_manager/widgets/loading/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrderList extends StatelessWidget {
  const UserOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      buildWhen: (previous, current) {
        return previous.orders != current.orders ||
            previous.isLoading != current.isLoading;
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingList();
        }

        if (state.orders.isEmpty) {
          return const EmptyOrdersList();
        }

        return ListView.separated(
          itemCount: state.orders.length,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 4),
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[200],
              thickness: 4,
              height: 4,
            );
          },
          itemBuilder: (context, index) {
            return UserOrderItemCreator().createOrderItem(
              context,
              state.orders[index],
            );
          },
        );
      },
    );
  }
}
