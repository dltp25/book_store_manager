import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RowData extends StatelessWidget {
  final String title;
  final String content;
  final TextStyle? contentStyle;

  const RowData({
    super.key,
    required this.title,
    required this.content,
    this.contentStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, color: Colors.black),
            ),
          ),
          const Gap(4),
          Text(
            content,
            style: contentStyle ??
                const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
          )
        ],
      ),
    );
  }
}
