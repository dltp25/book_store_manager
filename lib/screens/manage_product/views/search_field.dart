import '../bloc/manage_product_bloc.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSeatchField extends StatefulWidget {
  const ProductSeatchField({super.key});

  @override
  State<ProductSeatchField> createState() => _ProductSeatchFieldState();
}

class _ProductSeatchFieldState extends State<ProductSeatchField> {
  late TextEditingController _controller;
  bool showClearButton = false;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.themeColor,
      controller: _controller,
      style: TextStyle(
        fontSize: 14,
        color: AppColors.themeColor,
        fontWeight: FontWeight.w600,
      ),
      onChanged: (value) {
        context
            .read<ManageProductBloc>()
            .add(SearchProductEvent(query: value.trim()));
        if (value.isNotEmpty) {
          if (!showClearButton) {
            setState(() {
              showClearButton = true;
            });
          }
        } else {
          setState(() {
            showClearButton = false;
          });
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        hintText: "Tìm kiếm sản phẩm...",
        hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: showClearButton
            ? IconButton(
                onPressed: () {
                  _controller.text = "";
                  context
                      .read<ManageProductBloc>()
                      .add(const SearchProductEvent(query: ''));
                  setState(() {
                    showClearButton = false;
                  });
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.orangeAccent[700],
                ),
              )
            : null,
      ),
    );
  }
}
