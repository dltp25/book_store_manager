import 'package:flutter/material.dart';

class OrderDetailsRowInfoSpace extends StatelessWidget {
  final String title;
  final String? content;
  final TextStyle? contentStyle;
  final int? maxLines;

  const OrderDetailsRowInfoSpace({
    super.key,
    required this.title,
    required this.content,
    this.contentStyle,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Expanded(
            child: Text(
              content ?? '-/-',
              maxLines: maxLines ?? 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: contentStyle ??
                  const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
