import 'package:flutter/material.dart';

class OrderStatusTab extends StatelessWidget {
  final String title;
  final int count;

  const OrderStatusTab({super.key, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      alignment: Alignment.center,
      child: count > 0
          ? Text("$title (${count.toStringAsFixed(0)})")
          : Text(title),
    );
  }
}
