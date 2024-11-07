import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StatisticItem extends StatelessWidget {
  final String title;
  final String content;
  final String imgPath;
  final Color? color;

  const StatisticItem({
    super.key,
    required this.title,
    required this.content,
    this.color,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  imgPath,
                  fit: BoxFit.contain,
                  height: 26,
                  width: 26,
                  color: color != null
                      ? color!.withOpacity(0.4)
                      : Colors.tealAccent[700]!.withOpacity(0.4),
                ),
                const Gap(4),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Text(
                  content,
                  style: TextStyle(
                    color: color != null ? color! : Colors.tealAccent[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
