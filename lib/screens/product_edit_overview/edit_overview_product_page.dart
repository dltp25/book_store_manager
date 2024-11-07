import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/models/product_model.dart';
import 'package:book_store_manager/repositories/repository.dart';
import '../../models/book_type_model.dart';
import 'views/year_selector_textfield.dart';
import 'bloc/product_edit_overview_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/confirm_update_button.dart';
import 'views/booktype_selector.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditOverviewProductPage extends StatelessWidget {
  final ProductModel product;

  const EditOverviewProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductEditOverviewBloc(
        RepositoryProvider.of<AppRepository>(context).productRepository,
      )..add(InitialEvent(product: product)),
      child: BlocListener<ProductEditOverviewBloc, ProductEditOverviewState>(
        listener: (context, state) {
          if (state is UpdateSuccessfulState) {
            Navigator.of(context).pop(true);
          }
        },
        child: _EditPageContent(product: product),
      ),
    );
  }
}

class _EditPageContent extends StatefulWidget {
  final ProductModel product;
  const _EditPageContent({required this.product});

  @override
  State<_EditPageContent> createState() => __EditPageContentState();
}

class __EditPageContentState extends State<_EditPageContent> {
  late TextEditingController _cName, _cAuthor, _cPublisher, _cDescriptions;

  late FocusNode _fName, _fAuthor, _fPublisher, _fDescriptions;

  late BookType type;

  @override
  void initState() {
    super.initState();
    _cName = TextEditingController(text: widget.product.title);
    _cAuthor = TextEditingController(text: widget.product.author);
    _cPublisher = TextEditingController(text: widget.product.publisher);
    _cDescriptions = TextEditingController(text: widget.product.description);

    _fName = FocusNode();
    _fAuthor = FocusNode();
    _fPublisher = FocusNode();
    _fDescriptions = FocusNode();

    type = BookTypesModel.codeToType[widget.product.type]!;
  }

  @override
  void dispose() {
    _cName.dispose();
    _cAuthor.dispose();
    _cPublisher.dispose();
    _cDescriptions.dispose();

    _fName.dispose();
    _fAuthor.dispose();
    _fPublisher.dispose();
    _fDescriptions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: 'Sản phẩm: Thông tin chung',
          color: Colors.orangeAccent[700]!,
          imgBg: AppIcons.inventoryFill,
        ),
        bottomNavigationBar: ConfirmUpdateButton(product: widget.product),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tên sản phẩm',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const Gap(4),
                BlocBuilder<ProductEditOverviewBloc, ProductEditOverviewState>(
                  buildWhen: (previous, current) {
                    return previous.errTitle != current.errTitle;
                  },
                  builder: (context, state) {
                    return TextField(
                      onChanged: (value) {
                        context.read<ProductEditOverviewBloc>().add(
                              UpdateTitleEvent(newTitle: value),
                            );
                      },
                      controller: _cName,
                      focusNode: _fName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      cursorColor: AppColors.themeColor,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      decoration: _customDecoration(hint: widget.product.title)
                          .copyWith(
                        errorText: state.errTitle == '' ? null : state.errTitle,
                      ),
                    );
                  },
                ),
                const Gap(12),
                const Text(
                  'Tác giả',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const Gap(4),
                BlocBuilder<ProductEditOverviewBloc, ProductEditOverviewState>(
                  buildWhen: (previous, current) {
                    return previous.errAuthor != current.errAuthor;
                  },
                  builder: (context, state) {
                    return TextField(
                      onChanged: (value) {
                        context.read<ProductEditOverviewBloc>().add(
                              UpdateAuthorEvent(newAuthor: value),
                            );
                      },
                      controller: _cAuthor,
                      focusNode: _fAuthor,
                      style: const TextStyle(fontSize: 13),
                      cursorColor: AppColors.themeColor,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: _customDecoration(
                        hint: widget.product.author,
                      ).copyWith(
                        errorText:
                            state.errAuthor == '' ? null : state.errAuthor,
                      ),
                    );
                  },
                ),
                const Gap(12),
                const Text(
                  'Nhà xuất bản',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const Gap(4),
                BlocBuilder<ProductEditOverviewBloc, ProductEditOverviewState>(
                  buildWhen: (previous, current) {
                    return previous.errPublisher != current.errPublisher;
                  },
                  builder: (context, state) {
                    return TextField(
                      onChanged: (value) {
                        context.read<ProductEditOverviewBloc>().add(
                              UpdatePublisherEvent(newPublisher: value),
                            );
                      },
                      controller: _cPublisher,
                      focusNode: _fPublisher,
                      style: const TextStyle(fontSize: 13),
                      cursorColor: AppColors.themeColor,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      decoration: _customDecoration(
                        hint: widget.product.publisher,
                      ).copyWith(
                        errorText: state.errPublisher == ''
                            ? null
                            : state.errPublisher,
                      ),
                    );
                  },
                ),
                const Gap(12),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Năm xuất bản',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const Gap(4),
                          YearSelectorTextField(
                            initYear: widget.product.publishingYear,
                          ),
                        ],
                      ),
                    ),
                    const Gap(8),
                    const Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thể loại',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          Gap(4),
                          BookTypeSelector(),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                const Text(
                  'Mô tả',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const Gap(4),
                BlocBuilder<ProductEditOverviewBloc, ProductEditOverviewState>(
                  buildWhen: (previous, current) {
                    return previous.errDescription != current.errDescription;
                  },
                  builder: (context, state) {
                    return TextField(
                      onChanged: (value) {
                        context.read<ProductEditOverviewBloc>().add(
                              UpdateDescriptionEvent(newDescription: value),
                            );
                      },
                      controller: _cDescriptions,
                      focusNode: _fDescriptions,
                      style: const TextStyle(fontSize: 13),
                      maxLines: null,
                      cursorColor: AppColors.themeColor,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: _customDecoration(
                        hint: widget.product.description,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ).copyWith(
                        errorText: state.errDescription == ''
                            ? null
                            : state.errDescription,
                        errorMaxLines: 1,
                      ),
                    );
                  },
                ),
                const Gap(24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _customDecoration({
    String? hint,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13),
      contentPadding:
          contentPadding ?? const EdgeInsets.symmetric(horizontal: 12),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.themeColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.themeColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
