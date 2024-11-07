import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/repositories/repository.dart';
import 'package:book_store_manager/screens/user_report/views/report_item.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:book_store_manager/widgets/empty_report_list.dart';
import 'package:book_store_manager/widgets/loading/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user_report_bloc.dart';

class UserReportPage extends StatelessWidget {
  const UserReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserReportBloc(
        RepositoryProvider.of<AppRepository>(context).reportRepository,
      )..add(InitialEvent()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: 'Báo cáo vi phạm',
          color: Colors.orangeAccent[700]!,
          imgBg: AppIcons.exclamationFill,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Báo cáo mới đây',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
            Expanded(
              child: BlocBuilder<UserReportBloc, UserReportState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const LoadingList();
                  }

                  if (state.reports.isEmpty) {
                    return const EmptyReportList();
                  }

                  return ListView.builder(
                    itemCount: state.reports.length,
                    itemBuilder: (context, index) {
                      return ReportItem(reportModel: state.reports[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
