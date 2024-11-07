import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/repositories/repository.dart';
import 'views/product_feedback_item.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/utils/enum_convert.dart';
import 'package:book_store_manager/widgets/empty_feedback_list.dart';
import 'package:book_store_manager/widgets/loading/loading_list.dart';
import 'package:gap/gap.dart';
import 'views/product_information_loading.dart';
import 'views/product_information.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product_feedback_bloc.dart';

class ProductFeedbackPage extends StatelessWidget {
  final String productId;

  const ProductFeedbackPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductFeedbackBloc(
        RepositoryProvider.of<AppRepository>(context).productRepository,
        RepositoryProvider.of<AppRepository>(context).feedbackRepository,
      )..add(ProductFeedbackLoading(productId: productId)),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Đánh giá về sản phẩm',
          color: Colors.orangeAccent[700]!,
          imgBg: AppIcons.feedbackFill,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ProductFeedbackBloc, ProductFeedbackState>(
              buildWhen: (previous, current) {
                return previous.isLoading != current.isLoading ||
                    previous.product != current.product;
              },
              builder: (context, state) {
                if (state.isLoading || state.product == null) {
                  return const ProductInformationLoading();
                }

                return ProductInformation(product: state.product!);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Đánh giá của khách hàng',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.orangeAccent[700],
                ),
              ),
            ),
            SizedBox(
              height: 34,
              child: BlocBuilder<ProductFeedbackBloc, ProductFeedbackState>(
                buildWhen: (previous, current) {
                  return previous.viewType != current.viewType;
                },
                builder: (context, state) {
                  return ListView.separated(
                    itemCount: FeedbackViewType.values.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    separatorBuilder: (context, index) {
                      return const Gap(8);
                    },
                    itemBuilder: (context, index) {
                      bool selected =
                          state.viewType == FeedbackViewType.values[index];

                      return ChoiceChip(
                        onSelected: (value) {
                          context.read<ProductFeedbackBloc>().add(
                                UpdateFeedbackViewType(
                                  type: FeedbackViewType.values[index],
                                ),
                              );
                        },
                        label: Row(
                          children: [
                            Text(
                              EnumConvert.feedbackToString(
                                  FeedbackViewType.values[index]),
                            ),
                            const Gap(4),
                            Icon(
                              Icons.star,
                              color: selected
                                  ? AppColors.themeColor.withOpacity(0.8)
                                  : AppColors.themeColor.withOpacity(0.3),
                              size: 14,
                            ),
                          ],
                        ),
                        selected: selected,
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: selected
                              ? AppColors.themeColor.withOpacity(0.8)
                              : Colors.grey[400],
                          fontWeight: selected ? FontWeight.w600 : null,
                        ),
                        elevation: 0,
                        checkmarkColor: AppColors.themeColor,
                        side: BorderSide(
                          color: selected == false
                              ? Colors.grey[300]!
                              : Colors.transparent,
                        ),
                        selectedColor: AppColors.themeColor.withOpacity(0.1),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 6,
                        ),
                        labelPadding: const EdgeInsets.only(left: 4, right: 2),
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductFeedbackBloc, ProductFeedbackState>(
                buildWhen: (previous, current) {
                  return previous.isLoading != current.isLoading ||
                      previous.showedFeedbacks != current.showedFeedbacks;
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return const LoadingList();
                  }

                  if (state.showedFeedbacks.isEmpty) {
                    return const EmptyFeedbackList();
                  }

                  return ListView.separated(
                    itemCount: state.showedFeedbacks.length,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    separatorBuilder: (context, index) {
                      return const Divider(
                        indent: 12,
                        endIndent: 12,
                        color: Colors.grey,
                        thickness: 0,
                        height: 8,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ProductFeedbackItem(
                        key: ObjectKey(state.showedFeedbacks[index].id),
                        feedback: state.showedFeedbacks[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
