import 'package:flutter/material.dart';

class SearchOrderField extends StatefulWidget {
  const SearchOrderField({super.key});

  @override
  State<SearchOrderField> createState() => _SearchOrderFieldState();
}

class _SearchOrderFieldState extends State<SearchOrderField> {
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
    return SizedBox(
      height: 42,
      child: TextField(
        controller: _controller,
        cursorColor: Colors.grey[700],
        style: const TextStyle(fontSize: 13),
        onChanged: (value) {
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
          hintText: "Nhập SĐT hoặc Tên khách hàng",
          hintStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(Icons.search, size: 20),
          suffixIcon: showClearButton
              ? IconButton(
                  onPressed: () {
                    _controller.text = "";

                    setState(() {
                      showClearButton = false;
                    });
                  },
                  icon: const Icon(Icons.cancel, size: 20),
                )
              : null,
        ),
      ),
    );
  }
}
