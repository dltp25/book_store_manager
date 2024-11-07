import 'package:book_store_manager/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../utils/date_time.dart';
import '../bloc/logging_bloc.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoggingBloc, LoggingState>(
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
                      child: CustomDatePicker(
                        initTime: state.selectedDate ?? DateTime.now(),
                      ),
                    )
                  ],
                );
              },
            ).then((value) {
              if (value != null) {
                context.read<LoggingBloc>().add(
                      UpdateSelectedDateEvent(selectedDate: value),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.selectedDate == null
                      ? "Chọn ngày"
                      : DateTimeUtils.feedbackTime(state.selectedDate!),
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
