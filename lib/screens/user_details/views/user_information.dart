import 'package:book_store_manager/models/user_model.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInformation extends StatelessWidget {
  final UserModel user;
  const UserInformation({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              user.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const Gap(4),
            Text(
              user.isMale ? "(Nam)" : "(Nữ)",
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        Row(
          children: [
            Icon(MdiIcons.phone, size: 16, color: Colors.black54),
            const Gap(4),
            Text(
              user.phoneNumber,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const Spacer(),
            SizedBox(
              height: 32,
              child: TextButton(
                onPressed: () {
                  Uri uri = Uri(scheme: 'tel', path: user.phoneNumber);
                  launchUrl(uri);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Gọi',
                  style: TextStyle(
                    color: AppColors.themeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(MdiIcons.cakeVariant, size: 16, color: Colors.black54),
            const Gap(4),
            Text(
              user.birthday,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
