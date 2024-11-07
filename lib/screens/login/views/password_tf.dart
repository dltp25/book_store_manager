import '../bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes/colors.dart';
import 'styles.dart';

class PasswordTF extends StatefulWidget {
  const PasswordTF({super.key});

  @override
  State<PasswordTF> createState() => _PasswordTFState();
}

class _PasswordTFState extends State<PasswordTF> {
  late bool isUnShowPass;

  @override
  void initState() {
    isUnShowPass = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.visiblePassword,
          style: const TextStyle(fontSize: 14),
          obscureText: isUnShowPass,
          cursorColor: AppColors.themeColor,
          decoration: InputDecoration(
            errorText: state.errPassword.isEmpty ? null : state.errPassword,
            hintText: 'Mật khẩu',
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            prefixIcon: Icon(Icons.vpn_key, color: AppColors.themeColor),
            enabledBorder: AuthStyles.tfBorder,
            focusedBorder: AuthStyles.tfBorder,
            focusedErrorBorder: AuthStyles.tfBorder,
            errorBorder: AuthStyles.tfBorder,
            suffixIcon: IconButton(
              color: AppColors.themeColor,
              icon:
                  Icon(isUnShowPass ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  isUnShowPass = !isUnShowPass;
                });
              },
            ),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(UpdatePassword(password: value));
          },
          onSubmitted: (value) {
            context.read<LoginBloc>().add(LoggingEvent());
          },
        );
      },
    );
  }
}
