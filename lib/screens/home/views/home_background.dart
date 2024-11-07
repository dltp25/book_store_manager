import 'package:flutter/material.dart';

import '../../../constant/app_images.dart';

class HomeBackground extends StatelessWidget {
  final Widget child;
  const HomeBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(AppImages.homeBackground),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: child,
    );
  }
}
