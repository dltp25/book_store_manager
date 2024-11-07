import "../bloc/manage_user_bloc.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes/colors.dart';

class UserSearchField extends StatefulWidget {
  const UserSearchField({super.key});

  @override
  State<UserSearchField> createState() => _UserSearchFieldState();
}

class _UserSearchFieldState extends State<UserSearchField> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextField(
        cursorColor: AppColors.themeColor,
        controller: _controller,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.themeColor,
          fontWeight: FontWeight.w600,
        ),
        onChanged: (value) {
          context.read<ManageUserBloc>().add(SearchingEvent(query: value));
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
          hintText: "Tên khách hàng...",
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
                        .read<ManageUserBloc>()
                        .add(const SearchingEvent(query: ''));
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
      ),
    );
  }
}
