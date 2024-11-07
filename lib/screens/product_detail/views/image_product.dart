import 'package:gap/gap.dart';

import '../bloc/product_detail_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../widgets/data_form.dart';
import '../../../widgets/title.dart';
import '../photo_gallery_view.dart';

class ImageProduct extends StatelessWidget {
  const ImageProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return DataForm(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: Column(
        children: [
          const Row(
            children: [
              MyTitle(text: 'Hình ảnh', padding: EdgeInsets.zero),
              Spacer(),
            ],
          ),
          const Gap(10),
          BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.orangeAccent[700]!,
                    size: 40,
                  ),
                );
              }

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
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return PhotoGalleryView(
                            imgUrls: state.productData!.showImages,
                            initIndex: index,
                          );
                        },
                      ));
                    },
                    child: CachedNetworkImage(
                      imageUrl: state.productData!.showImages[index],
                      fit: BoxFit.contain,
                      placeholder: (context, url) {
                        return Container(
                          color: Colors.grey[300],
                        );
                      },
                    ),
                  );
                },
                itemCount: state.productData!.showImages.length,
              );
            },
          )
        ],
      ),
    );
  }
}
