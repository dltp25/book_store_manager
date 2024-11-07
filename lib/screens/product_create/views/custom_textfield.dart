import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../themes/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final String? errorText;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String? suffixText;

  const CustomTextField({
    super.key,
    required this.hint,
    this.onChanged,
    this.contentPadding,
    required this.errorText,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.style,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.suffixText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      style: widget.style ?? const TextStyle(fontSize: 14),
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        hintText: widget.hint,
        counterText: '',
        errorText: widget.errorText,
        hintStyle: const TextStyle(fontSize: 13),
        contentPadding:
            widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 12),
        fillColor: Colors.white,
        filled: true,
        suffixText: widget.suffixText,
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
      ),
    );
  }
}
