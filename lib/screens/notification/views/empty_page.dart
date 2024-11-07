import 'package:flutter/material.dart';

import '../../../constant/app_images.dart';

class EmptyNotificationPage extends StatelessWidget {
  const EmptyNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 102,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.6,
                image: AssetImage(AppImages.bell),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            'Không có thông báo',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
