import 'package:book_store_manager/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class CustomMonthPicker extends StatefulWidget {
  final DateTime initTime;

  const CustomMonthPicker({super.key, required this.initTime});

  @override
  State<CustomMonthPicker> createState() => _CustomMonthPickerState();
}

class _CustomMonthPickerState extends State<CustomMonthPicker> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    _selectedDate = widget.initTime;
  }

  @override
  void didUpdateWidget(covariant CustomMonthPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initTime != widget.initTime) {
      setState(() {
        _init();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MonthPicker.single(
            selectedDate: _selectedDate,
            onChanged: (value) {
              setState(() {
                _selectedDate = value;
              });
            },
            firstDate: DateTime(2020),
            lastDate: DateTime.now(),
            datePickerStyles: DatePickerRangeStyles(
              defaultDateTextStyle: const TextStyle(fontSize: 14),
              currentDateStyle: TextStyle(
                fontSize: 14,
                color: AppColors.themeColor,
                fontWeight: FontWeight.w600,
              ),
              selectedDateStyle: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              selectedSingleDateDecoration: BoxDecoration(
                color: AppColors.themeColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            datePickerLayoutSettings: const DatePickerLayoutSettings(
              maxDayPickerRowCount: 4,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Hủy",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(width: 15),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, _selectedDate);
                },
                child: const Text(
                  "Xác nhận",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
        ],
      ),
    );
  }
}
