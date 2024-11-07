import 'package:book_store_manager/constant/app_fonts.dart';
import 'package:book_store_manager/repositories/services/authentication/authentication_service.dart';
import 'package:book_store_manager/screens/change_password/change_password_page.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_images.dart';
import '../../logging/logging_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orangeAccent[700],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logoTransCrop,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                Text(
                  'App For Manager',
                  style: TextStyle(
                    fontFamily: AppFonts.dancingScript,
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'Đổi mật khẩu',
              style: TextStyle(fontSize: 14),
            ),
            leading: const Icon(Icons.password_outlined, size: 20),
            style: ListTileStyle.drawer,
            onTap: () {
              Navigator.of(context).push(
                PageRouteSlideTransition(child: const ChangePasswordPage()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Nhật ký hoạt động',
              style: TextStyle(fontSize: 14),
            ),
            leading: const Icon(Icons.history_edu, size: 20),
            style: ListTileStyle.drawer,
            onTap: () {
              Navigator.of(context).push(
                PageRouteSlideTransition(child: const LoggingScreen()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Đăng xuất',
              style: TextStyle(fontSize: 14),
            ),
            leading: const Icon(Icons.logout, size: 20),
            style: ListTileStyle.drawer,
            onTap: () {
              AuthenticationService.signOut();
            },
          ),
        ],
      ),
    );
  }
}
