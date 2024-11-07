import '../bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../themes/colors.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 48,
          margin: const EdgeInsets.only(top: 34, bottom: 18),
          child: ElevatedButton(
            onPressed: state.isLoading
                ? () {}
                : () {
                    context.read<LoginBloc>().add(LoggingEvent());
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: state.isLoading
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white,
                    size: 32,
                  )
                : const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
