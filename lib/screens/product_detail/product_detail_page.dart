import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/repositories/repository.dart';
import 'package:book_store_manager/screens/product_feedback/product_feedback_page.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import '../../widgets/custom_app_bar.dart';
import 'bloc/product_detail_bloc.dart';
import 'views/image_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/orther_information_product.dart';
import 'views/overview_product.dart';
import '../../widgets/title.dart';
import '../../widgets/data_form.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:gap/gap.dart';

import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  // final ProductModel product;
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailBloc(
        RepositoryProvider.of<AppRepository>(context).productRepository,
      )..add(InitialEvent(productId: productId, callAfterDataChange: false)),
      child: _ProductDetailContent(productId),
    );
  }
}

class _ProductDetailContent extends StatelessWidget {
  final String productId;
  const _ProductDetailContent(this.productId);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;

        Navigator.of(context).pop(
          context.read<ProductDetailBloc>().state.haveChange,
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: 'Thông tin sản phẩm',
          color: Colors.orangeAccent[700]!,
          imgBg: AppIcons.inventoryFill,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OverviewProduct(),
              const ImageProduct(),
              const OrderInformationProduct(),
              DataForm(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyTitle(
                      text: 'Đánh giá về sản phẩm',
                      padding: EdgeInsets.only(bottom: 4),
                    ),
                    const Gap(8),
                    SizedBox(
                      height: 44,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteSlideTransition(
                              child: ProductFeedbackPage(productId: productId),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: AppColors.themeColor,
                            ),
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: Text(
                          'Bấm để xem đánh giá về sản phẩm',
                          style: TextStyle(
                            color: AppColors.themeColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
