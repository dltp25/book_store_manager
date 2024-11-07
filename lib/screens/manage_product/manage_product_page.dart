import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/repositories/repository.dart';
import '../product_create/create_product_page.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import 'views/filter_product_dialog.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'views/total_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/manage_product_bloc.dart';
import 'views/product_list.dart';
import 'views/search_field.dart';
import 'package:gap/gap.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ManageProductPage extends StatelessWidget {
  const ManageProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageProductBloc(
        RepositoryProvider.of<AppRepository>(context).productRepository,
      )..add(ManageProductLoading()),
      child: const _ManageProductContent(),
    );
  }
}

class _ManageProductContent extends StatelessWidget {
  const _ManageProductContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Quản lý sản phẩm',
        imgBg: AppIcons.inventoryFill,
        color: Colors.orangeAccent[700]!,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(PageRouteSlideTransition(child: const CreateProductPage()))
              .then(
            (value) {
              if (value == true) {
                context.read<ManageProductBloc>().add(ManageProductLoading());
              }
            },
          );
        },
        backgroundColor: Colors.orangeAccent[400]!,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(12),
          Row(
            children: [
              const Gap(6),
              const Expanded(child: ProductSeatchField()),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context2) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(16),
                            child: FilterProductDialog(
                              selectedBookTypes: context
                                  .read<ManageProductBloc>()
                                  .state
                                  .currentShowTypes,
                              inStockDescending: context
                                  .read<ManageProductBloc>()
                                  .state
                                  .inStockDescending,
                            ),
                          ),
                        ],
                      );
                    },
                  ).then((value) {
                    if (value != null) {
                      Map<String, bool?> sortValue =
                          value as Map<String, bool?>;

                      bool? inStockDescending = sortValue['inStockDescending'];

                      List<String> types = [];
                      if (sortValue['sgk'] == true) types.add('bt001');
                      if (sortValue['vh'] == true) types.add('bt002');
                      if (sortValue['tt'] == true) types.add('bt003');
                      if (sortValue['te'] == true) types.add('bt004');
                      if (sortValue['khkt'] == true) types.add('bt005');
                      if (sortValue['k'] == true) types.add('bt006');

                      context.read<ManageProductBloc>().add(
                            FilterProductEvent(
                              bookType: types,
                              inStockDescending: inStockDescending,
                            ),
                          );
                    }
                  });
                },
                icon: Icon(
                  MdiIcons.filterOutline,
                  color: Colors.orangeAccent[700],
                ),
              ),
            ],
          ),
          const Gap(12),
          const TotalProduct(),
          const Expanded(child: ProductList()),
        ],
      ),
    );
  }
}
