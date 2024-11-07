import 'package:book_store_manager/themes/colors.dart';
import 'package:flutter/material.dart';

class OrderStatusItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const OrderStatusItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          splashColor: AppColors.themeColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
