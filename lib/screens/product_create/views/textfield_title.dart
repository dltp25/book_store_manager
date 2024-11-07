import 'package:flutter/material.dart';

class TextFieldTitle extends StatelessWidget {
  final String title;
  final double topSpace;
  final double bottomSpace;

  const TextFieldTitle({
    super.key,
    required this.title,
    this.topSpace = 0,
    this.bottomSpace = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpace, top: topSpace),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
