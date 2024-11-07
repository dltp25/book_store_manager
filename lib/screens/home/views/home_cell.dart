import 'package:book_store_manager/themes/texts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeCell extends StatelessWidget {
  final String content;
  final Color color;
  final String img;
  final String imgBg;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final VoidCallback? onTap;

  const HomeCell({
    super.key,
    required this.content,
    required this.color,
    required this.img,
    this.begin,
    this.end,
    required this.imgBg,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.3)],
            begin: begin ?? Alignment.topLeft,
            end: end ?? Alignment.bottomRight,
          ),
          image: DecorationImage(
            opacity: 0.2,
            fit: BoxFit.contain,
            image: AssetImage(imgBg),
            alignment: Alignment.centerRight,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.grey,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Gap(10),
                Image.asset(
                  img,
                  height: 24,
                  fit: BoxFit.fitHeight,
                ),
                const Gap(10),
                Expanded(child: Text(content, style: AppTexts.homeCell)),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
