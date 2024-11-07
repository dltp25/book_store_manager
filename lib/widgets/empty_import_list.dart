import '../constant/app_images.dart';
import 'package:flutter/material.dart';

class EmptyImportList extends StatelessWidget {
  const EmptyImportList({super.key});

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
                image: AssetImage(AppImages.clipboard),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            'Lịch sử nhập hàng trống',
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
