import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../themes/colors.dart';

class WarningDialog extends StatelessWidget {
  final Widget child;
  final String? cancelString;

  const WarningDialog({super.key, required this.child, this.cancelString});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.8,
          padding:
              const EdgeInsets.only(top: 24, bottom: 16, left: 10, right: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              child,
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(
                              color: AppColors.themeColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text(
                          cancelString ?? 'Thoát',
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
