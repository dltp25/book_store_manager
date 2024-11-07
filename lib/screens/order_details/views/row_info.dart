import 'package:flutter/material.dart';

class OrderDetailsRowInfo extends StatelessWidget {
  final String title;
  final String content;

  const OrderDetailsRowInfo({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$title: ",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          TextSpan(
            text: content,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
