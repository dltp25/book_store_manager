import 'package:book_store_manager/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../widgets/month_picker.dart';
import '../bloc/feedback_bloc.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      buildWhen: (previous, current) {
        return previous.selectedMonth != current.selectedMonth ||
            previous.type != current.type;
      },
      builder: (context, state) {
        return GestureDetector(
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
                context.read<FeedbackBloc>().add(
                      FeedbackUpdateMonthEvent(month: value),
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
                  state.selectedMonth == null
                      ? "Chọn tháng"
                      : DateTimeUtils.monthYearString(state.selectedMonth!),
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
