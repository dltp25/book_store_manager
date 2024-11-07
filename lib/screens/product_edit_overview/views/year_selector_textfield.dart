import '../bloc/product_edit_overview_bloc.dart';
import 'package:book_store_manager/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/year_picker.dart';

class YearSelectorTextField extends StatefulWidget {
  final String initYear;

  const YearSelectorTextField({super.key, required this.initYear});

  @override
  State<YearSelectorTextField> createState() => _YearSelectorTextFieldState();
}

class _YearSelectorTextFieldState extends State<YearSelectorTextField> {
  late String _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initYear;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _currentValue,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 0.8,
                            maxHeight: MediaQuery.sizeOf(context).height * 0.8,
                          ),
                          child: CustomYearPicker(
                            initTime: DateTimeUtils.stringToYear(_currentValue),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ).then((value) {
                if (value != null) {
                  setState(() {
                    _currentValue = DateTimeUtils.getYear(value);
                  });

                  context.read<ProductEditOverviewBloc>().add(
                        UpdatePublishingYearEvent(newYear: value),
                      );
                }
              });
            },
            icon: const Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
    );
  }
}
