import 'package:book_store_manager/constant/app_images.dart';
import 'package:book_store_manager/screens/root/bloc/root_bloc.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequireSignOutPage extends StatelessWidget {
  const RequireSignOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 46),
              Image.asset(
                AppImages.blocUser,
                height: 140,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 26),
              const Text(
                'Invalid permission',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tài khoản này không được cấp quyền cho ứng dụng. Vui lòng liên hệ quản trị viên để biết thêm thông tin.',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              const SizedBox(height: 8),
              const Text(
                "This account is not authorized for the application. Please contact the administrator for further information.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<RootBloc>().add(SignOutEvent());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Đăng xuất',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
