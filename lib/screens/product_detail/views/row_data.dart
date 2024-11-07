import 'styles.dart';
import 'package:flutter/material.dart';

class RowData extends StatelessWidget {
  final String title;
  final String content;
  final bool spaceBetween;
  final TextStyle? contentStyle;
  final EdgeInsetsGeometry? padding;

  const RowData({
    super.key,
    required this.title,
    required this.content,
    this.spaceBetween = false,
    this.contentStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 2),
      child: spaceBetween
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$title: ", style: PRDStyle.rowTitle),
                Text(content, style: contentStyle ?? PRDStyle.rowContent)
              ],
            )
          : Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "$title: ", style: PRDStyle.rowTitle),
                  TextSpan(text: content, style: PRDStyle.rowContent),
                ],
              ),
            ),
    );
  }
}
