import 'package:flutter/material.dart';

import '../constant/app_images.dart';

class EmptyReportList extends StatelessWidget {
  const EmptyReportList({super.key});

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
                image: AssetImage(AppImages.bug),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            'Không có đánh giá nào',
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
