import 'package:book_store_manager/repositories/repository.dart';
import 'package:gap/gap.dart';
import 'views/feedback_hide_item.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:book_store_manager/widgets/empty_feedback_list.dart';
import 'package:book_store_manager/widgets/loading/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/app_icons.dart';
import 'bloc/feedback_hide_bloc.dart';

class FeedbackHidePage extends StatelessWidget {
  const FeedbackHidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackHideBloc(
        RepositoryProvider.of<AppRepository>(context).feedbackRepository,
      )..add(FeedbackHideLoadEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Đánh giá bị ẩn',
          imgBg: AppIcons.feedbackFill,
          color: Colors.orangeAccent[700]!,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Các bình luận bị ẩn',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
            const Gap(8),
            Expanded(
              child: BlocBuilder<FeedbackHideBloc, FeedbackHideState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const LoadingList();
                  }

                  if (state.feedbacks.isEmpty) {
                    return const EmptyFeedbackList();
                  }

                  DateTime nowTime = DateTime.now();
                  return ListView.builder(
                    itemCount: state.feedbacks.length,
                    itemBuilder: (context, index) {
                      return FeedbackHideItem(
                        feedback: state.feedbacks[index],
                        now: nowTime,
                      );
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
