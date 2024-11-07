import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/repositories/repository.dart';
import 'package:book_store_manager/widgets/dialogs/confirm_dialog.dart';
import 'package:flutter/services.dart';
import 'views/custom_textfield.dart';
import 'views/images_grid.dart';
import 'bloc/create_product_bloc.dart';
import 'views/publishing_year_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'views/booktype_selector.dart';
import 'views/textfield_title.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateProductBloc(
        RepositoryProvider.of<AppRepository>(context).productRepository,
      ),
      child: BlocListener<CreateProductBloc, CreateProductState>(
        listener: (context, state) {
          if (state is CreateSuccessState) {
            Navigator.of(context).pop(true);
          }
        },
        child: const _CreateProductContent(),
      ),
    );
  }
}

class _CreateProductContent extends StatelessWidget {
  const _CreateProductContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Sản phẩm: Tạo sản phẩm mới',
        color: Colors.orangeAccent[700]!,
        imgBg: AppIcons.inventoryFill,
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
                    cancelString: 'Thoát',
                    confirmString: 'Xác nhận',
                    child: Column(
                      children: [
                        Text(
                          'Tạo sản phẩm',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Gap(12),
                        Text(
                          'Xác nhận tạo mới sản phẩm?',
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
                  context.read<CreateProductBloc>().add(ConfirmCreateEvent());
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
              'Tạo sản phẩm',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextFieldTitle(title: 'Tên sách'),
              BlocBuilder<CreateProductBloc, CreateProductState>(
                buildWhen: (previous, current) {
                  return previous.titleErr != current.titleErr;
                },
                builder: (context, state) {
                  return CustomTextField(
                    hint: 'Enter Book title',
                    errorText: state.titleErr == '' ? null : state.titleErr,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]!),
                    onChanged: (p0) {
                      context
                          .read<CreateProductBloc>()
                          .add(UpdateTitleEvent(newTitle: p0));
                    },
                  );
                },
              ),
              const TextFieldTitle(title: 'Tác giả', topSpace: 8),
              BlocBuilder<CreateProductBloc, CreateProductState>(
                buildWhen: (previous, current) {
                  return previous.authorErr != current.authorErr;
                },
                builder: (context, state) {
                  return CustomTextField(
                    hint: 'Author',
                    errorText: state.authorErr == '' ? null : state.authorErr,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      context
                          .read<CreateProductBloc>()
                          .add(UpdateAuthorEvent(newAuthor: value));
                    },
                  );
                },
              ),
              const TextFieldTitle(title: 'Nhà xuất bản', topSpace: 8),
              BlocBuilder<CreateProductBloc, CreateProductState>(
                buildWhen: (previous, current) {
                  return previous.publisherErr != current.publisherErr;
                },
                builder: (context, state) {
                  return CustomTextField(
                    hint: 'Publisher',
                    errorText:
                        state.publisherErr == '' ? null : state.publisherErr,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      context
                          .read<CreateProductBloc>()
                          .add(UpdatePublisherEvent(newPublisher: value));
                    },
                  );
                },
              ),
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldTitle(title: 'Năm xuất bản', topSpace: 8),
                        PublishingYearSelector(),
                      ],
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldTitle(title: 'Thể loại', topSpace: 8),
                        BookTypeSelector(),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextFieldTitle(
                            title: 'Giá sản phẩm', topSpace: 8),
                        BlocBuilder<CreateProductBloc, CreateProductState>(
                          buildWhen: (previous, current) {
                            return previous.priceErr != current.priceErr;
                          },
                          builder: (context, state) {
                            return CustomTextField(
                              hint: 'Price',
                              errorText:
                                  state.priceErr == '' ? null : state.priceErr,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              suffixText: 'Vnđ',
                              onChanged: (value) {
                                context
                                    .read<CreateProductBloc>()
                                    .add(UpdatePriceEvent(newPrice: value));
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextFieldTitle(title: 'Giảm giá', topSpace: 8),
                        BlocBuilder<CreateProductBloc, CreateProductState>(
                          buildWhen: (previous, current) {
                            return previous.priceErr != current.priceErr;
                          },
                          builder: (context, state) {
                            return CustomTextField(
                              hint: 'Discount',
                              errorText: state.discountErr == ''
                                  ? null
                                  : state.discountErr,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              suffixText: '%',
                              onChanged: (value) {
                                context.read<CreateProductBloc>().add(
                                    UpdateDiscountEvent(newDiscount: value));
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TextFieldTitle(title: 'Hình ảnh', topSpace: 8),
                  BlocBuilder<CreateProductBloc, CreateProductState>(
                    buildWhen: (previous, current) {
                      return previous.imageErr != current.imageErr;
                    },
                    builder: (context, state) {
                      if (state.imageErr == '') {
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 4, left: 6),
                        child: Text(
                          state.imageErr,
                          style: TextStyle(
                              color: Colors.redAccent[700], fontSize: 12),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const ImagesGrid(),
              const TextFieldTitle(title: 'Mô tả', topSpace: 8),
              BlocBuilder<CreateProductBloc, CreateProductState>(
                buildWhen: (previous, current) {
                  return previous.descriptionErr != current.descriptionErr;
                },
                builder: (context, state) {
                  return CustomTextField(
                    hint: 'Description',
                    errorText: state.descriptionErr == ''
                        ? null
                        : state.descriptionErr,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    maxLines: null,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    onChanged: (value) {
                      context
                          .read<CreateProductBloc>()
                          .add(UpdateDescriptionEvent(newDescription: value));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
