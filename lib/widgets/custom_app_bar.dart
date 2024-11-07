import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/themes/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? imgBg;
  final Color color;
  final List<Widget> actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.imgBg,
    required this.color,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.contentColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      title: Text(title, style: AppTexts.appbarTitle),
      centerTitle: true,
      actions: actions,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          image: imgBg != null
              ? DecorationImage(
                  image: AssetImage(imgBg!),
                  opacity: 0.2,
                  alignment: Alignment.centerRight,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
