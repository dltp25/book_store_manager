import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/date_time.dart';
import '../../../widgets/year_picker.dart';
import '../bloc/create_product_bloc.dart';

class PublishingYearSelector extends StatelessWidget {
  const PublishingYearSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 12),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BlocBuilder<CreateProductBloc, CreateProductState>(
              buildWhen: (previous, current) {
                return previous.publishingYear != current.publishingYear;
              },
              builder: (context, state) {
                return Text(
                  state.publishingYear,
                  style: const TextStyle(fontSize: 14),
                );
              },
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context2) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context2).width * 0.8,
                            maxHeight: MediaQuery.sizeOf(context2).height * 0.8,
                          ),
                          child: CustomYearPicker(
                            initTime: DateTimeUtils.stringToYear(context
                                .read<CreateProductBloc>()
                                .state
                                .publishingYear),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ).then((value) {
                if (value != null) {
                  context
                      .read<CreateProductBloc>()
                      .add(UpdatePublishingYearEvent(newYear: value));
                }
              });
            },
            icon: Icon(
              Icons.calendar_month_outlined,
              color: Colors.grey[700]!,
            ),
          ),
        ],
      ),
    );
  }
}
