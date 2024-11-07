import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/models/product_model.dart';
import 'package:book_store_manager/repositories/repository.dart';
import 'package:book_store_manager/widgets/dialogs/confirm_dialog.dart';
import 'views/create_import_item.dart';
import 'package:book_store_manager/widgets/loading/loading_list.dart';
import 'package:gap/gap.dart';
import 'bloc/create_import_product_bloc.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'views/product_picker_dialog.dart';

class CreateImportProductPage extends StatelessWidget {
  const CreateImportProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateImportProductBloc(
        RepositoryProvider.of<AppRepository>(context).productRepository,
        RepositoryProvider.of<AppRepository>(context).importRepository,
      )..add(InitialEvent()),
      child: BlocListener<CreateImportProductBloc, CreateImportProductState>(
        listener: (context, state) {
          if (state is ImportCompleteState) {
            Navigator.of(context).pop();
          }
        },
        child: const _CreateImportPageContent(),
      ),
    );
  }
}

class _CreateImportPageContent extends StatelessWidget {
  const _CreateImportPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Nhập hàng: Tạo đơn',
        color: Colors.orangeAccent[700]!,
        imgBg: AppIcons.add,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          top: 8,
          bottom: 8 + MediaQuery.of(context).padding.bottom,
        ),
        child: SizedBox(
          height: 44,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const ConfirmDialog(
                    confirmString: 'Nhập hàng',
                    cancelString: 'Hủy',
                    child: Column(
                      children: [
                        Text(
                          'Thêm hàng vào kho',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Gap(12),
                        Text(
                          'Xác nhận cập nhật số lượng sản phẩm trên trong kho hàng?',
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                        Gap(12),
                      ],
                    ),
                  );
                },
              ).then((value) {
                if (value == true) {
                  context
                      .read<CreateImportProductBloc>()
                      .add(ConfirmImportEvent());
                }
              });
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Nhập hàng',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sản phẩm',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  '(Vuốt sang phải để xóa)',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                BlocBuilder<CreateImportProductBloc, CreateImportProductState>(
              builder: (context, state) {
                if (state is ImportCompleteState) {
                  return const SizedBox.shrink();
                }

                if (state.isLoading) {
                  return const LoadingList();
                }

                return ListView.separated(
                  itemCount: state.products.length + 1,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: AppColors.background,
                      thickness: 4,
                      height: 4,
                    );
                  },
                  itemBuilder: (context, index) {
                    if (index != state.products.length) {
                      return CreateImportItem(
                        key: ObjectKey(
                          state.products.keys.elementAt(index).productId,
                        ),
                        productLiteModel: state.products.keys.elementAt(index),
                        number: state.products.values.elementAt(index),
                      );
                    }
                    return TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ProductPickerDialog(
                              allProduct: state.allProduct,
                              selectedProduct: state.products.keys.toList(),
                            );
                          },
                        ).then((value) {
                          if (value != null) {
                            value as ProductLiteModel;
                            context
                                .read<CreateImportProductBloc>()
                                .add(AddProductEvent(product: value));
                          }
                        });
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Thêm sản phẩm',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                          Gap(4),
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
