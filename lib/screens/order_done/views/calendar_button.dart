import 'package:book_store_manager/widgets/month_picker.dart';

import '../bloc/order_done_bloc.dart';
import 'package:book_store_manager/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CalendarButton extends StatefulWidget {
  const CalendarButton({super.key});

  @override
  State<CalendarButton> createState() => _CalendarButtonState();
}

class _CalendarButtonState extends State<CalendarButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDoneBloc, OrderDoneState>(
      buildWhen: (previous, current) {
        return previous.selectedMonth != current.selectedMonth;
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width * 0.8,
                        maxHeight: MediaQuery.sizeOf(context).height * 0.8,
                      ),
                      child: CustomMonthPicker(
                        initTime: state.selectedMonth ?? DateTime.now(),
                      ),
                    )
                  ],
                );
              },
            ).then((value) {
              if (value != null) {
                context.read<OrderDoneBloc>().add(
                      UpdateSelectedMonthEvent(selectedMonth: value),
                    );
              }
            });
          },
          child: Container(
            height: 32,
            padding: const EdgeInsets.only(left: 12, right: 6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white.withOpacity(0.5),
              border: Border.all(color: Colors.grey, width: 0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state.selectedMonth != null
                      ? DateTimeUtils.monthYearString(state.selectedMonth!)
                      : "Chọn tháng",
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                ),
                const Gap(8),
                const Icon(Icons.calendar_month_outlined, size: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
