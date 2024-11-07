import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/models/book_type_model.dart';
import '../bloc/product_edit_overview_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookTypeSelector extends StatelessWidget {
  const BookTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        dropdownStyleData: DropdownStyleData(
          offset: const Offset(0, -5),
          elevation: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(height: 32),
        customButton: Container(
          height: 48,
          padding: const EdgeInsets.only(left: 12, right: 6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: BlocBuilder<ProductEditOverviewBloc,
                    ProductEditOverviewState>(
                  builder: (context, state) {
                    return Text(
                      BookTypesModel.typeToDes[state.type] ?? "NullType",
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                    );
                  },
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded),
            ],
          ),
        ),
        onChanged: (value) {
          if (value != null) {
            context.read<ProductEditOverviewBloc>().add(
                  UpdateBookTypeEvent(newType: value),
                );
          }
        },
        items: BookType.values
            .map(
              (e) => DropdownMenuItem(
                value: e,
                alignment: Alignment.center,
                child: Text(
                  BookTypesModel.typeToDes[e]!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
