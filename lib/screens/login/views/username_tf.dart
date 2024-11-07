import '../bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'styles.dart';
import 'package:flutter/material.dart';

import '../../../themes/colors.dart';

class UsernameTF extends StatefulWidget {
  const UsernameTF({super.key});

  @override
  State<UsernameTF> createState() => _UsernameTFState();
}

class _UsernameTFState extends State<UsernameTF> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(fontSize: 14),
          cursorColor: AppColors.themeColor,
          decoration: InputDecoration(
            errorText: state.errUsername.isEmpty ? null : state.errUsername,
            hintText: 'Email đăng nhập',
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            enabledBorder: AuthStyles.tfBorder,
            focusedBorder: AuthStyles.tfBorder,
            focusedErrorBorder: AuthStyles.tfBorder,
            errorBorder: AuthStyles.tfBorder,
            prefixIcon: Icon(
              Icons.person,
              color: AppColors.themeColor,
            ),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(UpdateUserName(userName: value));
          },
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
        );
      },
    );
  }
}
