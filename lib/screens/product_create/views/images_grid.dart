import 'dart:io';

import 'package:book_store_manager/widgets/dialogs/pick_image_option_dialog.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/create_product_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ImagesGrid extends StatelessWidget {
  const ImagesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductBloc, CreateProductState>(
      buildWhen: (previous, current) {
        return previous.images != current.images;
      },
      builder: (context, state) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: state.images.length + 1,
          itemBuilder: (context, index) {
            if (index < state.images.length) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(state.images[index], fit: BoxFit.cover),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: GestureDetector(
                        onTap: () {
                          context.read<CreateProductBloc>().add(
                                RemoveImageEvent(
                                  removedImage: state.images[index],
                                ),
                              );
                        },
                        child: Icon(Icons.cancel, color: Colors.grey[350]!),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  showPickImageOptionsDialog(context).then((value) {
                    if (value == 0) {
                      pickImageFromGallery().then((images) {
                        if (images.isNotEmpty) {
                          List<File> files =
                              images.map((e) => File(e.path)).toList();

                          context.read<CreateProductBloc>().add(
                                AddImageEvent(newImages: files),
                              );
                        }
                      });
                    } else if (value == 1) {
                      pickImageFromCamera().then((image) {
                        if (image != null) {
                          context.read<CreateProductBloc>().add(
                                AddImageEvent(
                                  newImages: [File(image.path)],
                                ),
                              );
                        }
                      });
                    }
                  });
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.image, color: Colors.grey),
                        Gap(4),
                        Text('Select', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<int?> showPickImageOptionsDialog(context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return const PickImageOptionDialog();
      },
    );
  }

  Future<List<XFile>> pickImageFromGallery() async {
    List<XFile> result = await ImagePicker().pickMultiImage();
    return result;
  }

  Future<XFile?> pickImageFromCamera() async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.camera);
    return result;
  }
}
