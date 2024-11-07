import 'package:book_store_manager/models/product_model.dart';
import 'package:diacritic/diacritic.dart';
import 'dialog_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductPickerDialog extends StatefulWidget {
  final List<ProductLiteModel> allProduct;
  final List<ProductLiteModel> selectedProduct;

  const ProductPickerDialog({
    super.key,
    required this.allProduct,
    required this.selectedProduct,
  });

  @override
  State<ProductPickerDialog> createState() => _ProductPickerDialogState();
}

class _ProductPickerDialogState extends State<ProductPickerDialog> {
  List<ProductLiteModel> showedProduct = [];

  @override
  void initState() {
    showedProduct = List.from(widget.allProduct);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 16,
            bottom: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Chọn sản phẩm',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const Gap(16),
              TextField(
                onChanged: (value) {
                  String query = removeDiacritics(value.toLowerCase());
                  setState(() {
                    showedProduct = widget.allProduct
                        .where((element) =>
                            removeDiacritics(element.productName.toLowerCase())
                                .contains(query))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Tìm kiếm sản phẩm...",
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(Icons.search, size: 20),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
              const Gap(12),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.separated(
                  itemCount: showedProduct.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 4);
                  },
                  itemBuilder: (context, index) {
                    bool isSelected =
                        widget.selectedProduct.contains(showedProduct[index]);
                    return GestureDetector(
                      onTap: isSelected
                          ? null
                          : () {
                              Navigator.pop(context, showedProduct[index]);
                            },
                      child: DialogItem(
                        productLite: showedProduct[index],
                        isSelected: isSelected,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
