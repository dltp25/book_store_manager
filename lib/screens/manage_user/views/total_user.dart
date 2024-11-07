import '../bloc/manage_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalUser extends StatelessWidget {
  const TotalUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: BlocBuilder<ManageUserBloc, ManageUserState>(
        builder: (context, state) {
          return Text(
            '${state.showedUsers.length.toStringAsFixed(0)} khách hàng',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          );
        },
      ),
    );
  }
}
