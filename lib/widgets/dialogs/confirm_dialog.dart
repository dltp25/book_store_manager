import 'package:book_store_manager/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ConfirmDialog extends StatelessWidget {
  final Widget child;
  final String? cancelString;
  final String? confirmString;

  const ConfirmDialog({
    super.key,
    required this.child,
    this.cancelString,
    this.confirmString,
  });

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
              const Text(
                'Bạn có muốn tiếp tục?',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                ),
              ),
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
                          cancelString ?? 'Không',
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.themeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          confirmString ?? 'Có',
                          style: const TextStyle(
                            color: Colors.white,
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
