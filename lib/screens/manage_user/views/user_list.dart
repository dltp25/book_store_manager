import "../bloc/manage_user_bloc.dart";
import '../../../widgets/loading/loading_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_item.dart';
import 'package:flutter/material.dart';

import '../../../themes/colors.dart';
import 'styles.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text("STT", style: tableHead),
                ),
              ),
              Expanded(
                flex: 7,
                child: Center(
                  child: Text('Khách hàng', style: tableHead),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<ManageUserBloc, ManageUserState>(
            buildWhen: (previous, current) {
              return previous.showedUsers != current.showedUsers ||
                  previous.isLoading != current.isLoading;
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const LoadingList();
              }

              if (state.showedUsers.isEmpty) {
                return const Center(
                  child: Text(
                    'Không có khách hàng phù hợp',
                    style: TextStyle(fontSize: 13),
                  ),
                );
              }

              return ListView.separated(
                itemCount: state.showedUsers.length,
                padding: const EdgeInsets.only(bottom: 72),
                physics: const ClampingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return Divider(
                    color: AppColors.background,
                    height: 2,
                    thickness: 2,
                  );
                },
                itemBuilder: (context, index) {
                  return UserItem(
                    index: index + 1,
                    user: state.showedUsers[index],
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
