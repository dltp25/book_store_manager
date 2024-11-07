import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as lib;

import '../themes/colors.dart';

class CustomYearPicker extends StatefulWidget {
  final DateTime initTime;

  const CustomYearPicker({super.key, required this.initTime});

  @override
  State<CustomYearPicker> createState() => _CustomYearPickerState();
}

class _CustomYearPickerState extends State<CustomYearPicker> {
  DateTime _selectedDate = DateTime.now();
  late DateTime _lastDate;
  late DateTime _firstDate;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    _selectedDate = widget.initTime;
    _lastDate = DateTime.now();
    _firstDate = DateTime(_lastDate.year - 11 * 10);
  }

  @override
  void didUpdateWidget(covariant CustomYearPicker oldWidget) {
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
          lib.YearPicker.single(
            selectedDate: _selectedDate,
            onChanged: (value) {
              setState(() {
                _selectedDate = value;
              });
            },
            datePickerLayoutSettings: const lib.DatePickerLayoutSettings(
              maxDayPickerRowCount: 4,
            ),
            datePickerStyles: lib.DatePickerRangeStyles(
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
            firstDate: _firstDate,
            lastDate: _lastDate,
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
