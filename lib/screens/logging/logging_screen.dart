import 'package:book_store_manager/screens/logging/bloc/logging_bloc.dart';
import 'package:book_store_manager/screens/logging/views/date_selector.dart';
import 'package:book_store_manager/screens/logging/views/logging_item.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../repositories/services/logging/logging_service.dart';
import '../../widgets/custom_app_bar.dart';

class LoggingScreen extends StatefulWidget {
  const LoggingScreen({super.key});

  @override
  State<LoggingScreen> createState() => _LoggingScreenState();
}

class _LoggingScreenState extends State<LoggingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Hoạt động của khách hàng',
        color: Colors.orangeAccent[700]!,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(),
                ),
                DateSelector(),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<LoggingBloc, LoggingState>(
              builder: (context, state) {
                if (state.selectedDate == null) {
                  return const Center(
                    child: Text('Chưa chọn thời gian xem'),
                  );
                }

                return FirestoreListView.separated(
                  query: LoggingService().loggingQuery(state.selectedDate!),
                  itemBuilder: (context, doc) {
                    return LoggingItem(model: doc.data());
                  },
                  separatorBuilder: (context, index) {
                    return const Gap(8);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
