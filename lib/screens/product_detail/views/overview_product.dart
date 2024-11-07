import 'package:book_store_manager/models/book_type_model.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../themes/colors.dart';
import '../../../widgets/data_form.dart';
import '../../../widgets/title.dart';
import '../../product_edit_overview/edit_overview_product_page.dart';
import '../bloc/product_detail_bloc.dart';
import 'row_data.dart';
import 'styles.dart';

class OverviewProduct extends StatelessWidget {
  const OverviewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return DataForm(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Column(
              children: [
                Row(
                  children: [
                    const MyTitle(
                      text: 'Thông tin chung',
                      padding: EdgeInsets.zero,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Row(
                        children: [
                          Text(
                            'Chỉnh sửa ',
                            style: TextStyle(fontSize: 12),
                          ),
                          Icon(Icons.edit_square, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.orangeAccent[700]!,
                    size: 40,
                  ),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const MyTitle(
                    text: 'Thông tin chung',
                    padding: EdgeInsets.zero,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                        PageRouteSlideTransition(
                          child: EditOverviewProductPage(
                            product: state.productData!,
                          ),
                        ),
                      )
                          .then((value) {
                        if (value == true) {
                          context.read<ProductDetailBloc>().add(
                                InitialEvent(
                                  productId: state.productData!.id,
                                  callAfterDataChange: true,
                                ),
                              );
                        }
                      });
                    },
                    icon: const Row(
                      children: [
                        Text(
                          'Chỉnh sửa ',
                          style: TextStyle(fontSize: 12),
                        ),
                        Icon(Icons.edit_square, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.productData!.title,
                          style: PRDStyle.rowTitle.copyWith(
                            fontSize: 14,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                        Divider(color: AppColors.themeColor),
                        RowData(
                          title: 'Thể loại',
                          content: BookTypesModel
                                  .codeToDes[state.productData!.type] ??
                              'NullType',
                        ),
                        RowData(
                          title: 'Tác giả',
                          content: state.productData!.author,
                        ),
                        RowData(
                          title: 'Nhà xuất bản',
                          content: state.productData!.publisher,
                        ),
                        RowData(
                          title: 'Năm xuất bản',
                          content: state.productData!.publishingYear,
                        ),
                      ],
                    ),
                  ),
                  const Gap(6),
                  CachedNetworkImage(
                    imageUrl: state.productData!.mainImage,
                    width: 80,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              Divider(color: AppColors.themeColor),
              state.productData!.description.isEmpty
                  ? Text(
                      "(Không có mô tả)",
                      style: PRDStyle.rowContent.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  : ExpandableText(
                      state.productData!.description.replaceAll('\n', '\n'),
                      expandText: 'Xem thêm',
                      collapseText: 'Ẩn bớt',
                      maxLines: 4,
                      linkColor: AppColors.themeColor,
                      style: PRDStyle.rowContent.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
