import 'package:book_store_manager/themes/texts.dart';
import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;

  const MyTitle({
    super.key,
    required this.text,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 10),
      child: Text(text, style: AppTexts.dataTitle),
    );
  }
}
