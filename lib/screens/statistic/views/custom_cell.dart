import 'package:flutter/material.dart';

class CustomCell extends StatelessWidget {
  final String text;
  final bool bold;
  final Alignment alignment;

  const CustomCell({
    super.key,
    required this.text,
    this.bold = false,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        alignment: alignment,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
