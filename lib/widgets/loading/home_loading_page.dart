import 'package:book_store_manager/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeLoadingPage extends StatelessWidget {
  const HomeLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColors.themeColor,
      child: Center(
        child: LoadingAnimationWidget.inkDrop(color: Colors.white, size: 60),
      ),
    );
  }
}
