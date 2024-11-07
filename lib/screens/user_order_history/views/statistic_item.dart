import 'package:flutter/material.dart';

class StatisticItem extends StatelessWidget {
  final int value;
  final String title;
  final Color? valueColor;

  const StatisticItem({
    super.key,
    required this.value,
    required this.title,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value.toStringAsFixed(0),
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              overflow: TextOverflow.ellipsis,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
