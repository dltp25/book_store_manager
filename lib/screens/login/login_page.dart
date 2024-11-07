import '../forgot_password/forgot_password_page.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';

import 'bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/app_fonts.dart';
import '../../constant/app_images.dart';
import 'views/password_tf.dart';
import 'views/username_tf.dart';
import 'views/login_button.dart';
import '../../themes/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: AppColors.themeColor,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: AppColors.themeColor.withAlpha(200),
              image: DecorationImage(
                image: AssetImage(AppImages.authBackground),
                opacity: 0.15,
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Image.asset(
                    AppImages.logoTransCrop,
                    height: 68,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'For Manager',
                      style: TextStyle(
                        fontFamily: AppFonts.dancingScript,
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 24,
                    ),
                    margin: const EdgeInsets.only(bottom: 60, top: 34),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Đăng nhập',
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                        const SizedBox(height: 29),
                        const UsernameTF(),
                        const SizedBox(height: 12),
                        const PasswordTF(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteSlideTransition(
                                    child: const ForgotPasswordPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Quên mật khẩu?',
                                style: TextStyle(
                                  color: AppColors.themeColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const LoginButton(),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'V1.0.0.30.10.23',
                      style: TextStyle(color: Colors.black, fontSize: 11),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
