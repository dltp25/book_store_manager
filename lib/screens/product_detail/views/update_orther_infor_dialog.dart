import 'package:book_store_manager/utils/currency_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../../themes/colors.dart';

class UpdateOrtherInforDialog extends StatefulWidget {
  final double price;
  final double discount;

  const UpdateOrtherInforDialog(
      {super.key, required this.price, required this.discount});

  @override
  State<UpdateOrtherInforDialog> createState() =>
      _UpdateOrtherInforDialogState();
}

class _UpdateOrtherInforDialogState extends State<UpdateOrtherInforDialog> {
  late TextEditingController _priceController, _discountController;
  String? priceErr;

  @override
  void initState() {
    _priceController = TextEditingController(
      text: widget.price.toStringAsFixed(0),
    );
    _discountController = TextEditingController(
      text: (widget.discount * 100).toStringAsFixed(0),
    );
    super.initState();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.8,
          padding:
              const EdgeInsets.only(top: 16, bottom: 16, left: 10, right: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Cập nhật giá sản phẩm',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const Gap(16),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Giá gốc:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Gap(4),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 44,
                      child: TextField(
                        controller: _priceController,
                        onChanged: (value) {
                          setState(() {
                            priceErr = null;
                          });
                        },
                        style: const TextStyle(fontSize: 14),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: _customDecoration(
                          hint: CurrencyUtils.convertDoubleToCurrency(
                              widget.price),
                        ).copyWith(
                          suffixText: 'Vnđ',
                          suffixStyle: const TextStyle(color: Colors.grey),
                          errorText: priceErr,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(12),
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Giảm giá:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Gap(4),
                        Text('(Tối đa: 99%)', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  const Gap(4),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 44,
                      child: TextField(
                        controller: _discountController,
                        style: const TextStyle(fontSize: 14),
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: _customDecoration(hint: '0').copyWith(
                          suffixText: '%',
                          counterText: '',
                          suffixStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Gap(32),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: AppColors.themeColor,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Thoát',
                        style: TextStyle(color: AppColors.themeColor),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        bool hasErr = false;
                        if (_priceController.text.isEmpty) {
                          hasErr = true;
                          setState(() {
                            priceErr = '*Required';
                          });
                        }

                        if (hasErr == false) {
                          double discount = 0;
                          if (_discountController.text.isEmpty) {
                            discount = 0;
                          } else {
                            discount =
                                double.parse(_discountController.text) / 100;
                          }

                          Navigator.pop(
                            context,
                            {
                              'price': double.parse(_priceController.text),
                              'discount': discount,
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.themeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Cập nhật',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300]!),
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
