import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UserStatisticItem extends StatelessWidget {
  final String value;
  final String title;

  const UserStatisticItem(
      {super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Gap(4),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
