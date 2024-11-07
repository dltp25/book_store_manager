import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PickImageOptionDialog extends StatelessWidget {
  const PickImageOptionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      titlePadding: const EdgeInsets.only(top: 12, bottom: 8),
      elevation: 0,

      title: const Center(
        child: Text(
          "Chọn nguồn ảnh",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      children: [
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, 0);
          },
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(
                MdiIcons.folderImage,
                color: Colors.grey[700],
              ),
              const Gap(6),
              const Text(
                'Ảnh trong máy',
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, 1);
          },
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(
                MdiIcons.cameraImage,
                color: Colors.grey[700],
              ),
              const Gap(6),
              const Text(
                'Máy ảnh',
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
      // child: Center(
      //   child: Material(
      //     color: Colors.transparent,
      //     child: Container(
      //       width: MediaQuery.sizeOf(context).width * 0.8,
      //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //       margin: const EdgeInsets.symmetric(horizontal: 20),
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
