import 'package:flutter/material.dart';

class Styles {
  static TextStyle title = TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.orangeAccent[700],
    fontSize: 14,
  );

  static OutlineInputBorder enable = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.grey[350]!),
  );

  static OutlineInputBorder focused = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.orangeAccent[700]!),
  );

  static OutlineInputBorder enableError = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.red),
  );

  static OutlineInputBorder focusedError = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.red, width: 2),
  );
}
