import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/repositories/repository.dart';
import 'package:book_store_manager/screens/feedback_hide/feedback_hide_page.dart';
import 'package:book_store_manager/screens/product_feedback/product_feedback_page.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/widgets/empty_feedback_list.dart';
import 'package:book_store_manager/widgets/loading/loading_list.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import 'package:gap/gap.dart';
import 'bloc/feedback_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'views/feedback_item.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'views/month_selector.dart';

class ManageFeedbackPage extends StatelessWidget {
  const ManageFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackBloc(
        RepositoryProvider.of<AppRepository>(context).feedbackRepository,
        RepositoryProvider.of<AppRepository>(context).notiRepository,
      )..add(FeedbackLoadEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Đánh giá của khách hàng',
          imgBg: AppIcons.feedbackFill,
          color: Colors.orangeAccent[700]!,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  const MonthSelector(),
                  // Text(
                  //   'Gần đây',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w600,
                  //     fontSize: 14,
                  //     color: Colors.orangeAccent[700],
                  //   ),
                  // ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteSlideTransition(
                          child: const FeedbackHidePage(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Xem các đánh giá bị ẩn',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Gap(8),
                BlocBuilder<FeedbackBloc, FeedbackState>(
                  buildWhen: (previous, current) {
                    return previous.type != current.type ||
                        previous.selectedMonth != current.selectedMonth;
                  },
                  builder: (context, state) {
                    bool isSelect = state.type == ManageFeedbackType.unread;

                    return ChoiceChip(
                      onSelected: (value) {
                        context.read<FeedbackBloc>().add(
                              const FeedbackUpdateTypeEvent(
                                type: ManageFeedbackType.unread,
                              ),
                            );
                      },
                      selected: isSelect,
                      label: const Text('Chưa xem'),
                      checkmarkColor: AppColors.themeColor,
                      backgroundColor: isSelect ? null : Colors.white,
                      labelStyle: TextStyle(
                        color: isSelect ? AppColors.themeColor : Colors.grey,
                        fontSize: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: isSelect
                            ? BorderSide.none
                            : BorderSide(color: Colors.grey[300]!),
                      ),
                    );
                  },
                ),
                const Gap(8),
                BlocBuilder<FeedbackBloc, FeedbackState>(
                  buildWhen: (previous, current) {
                    return previous.type != current.type ||
                        previous.selectedMonth != current.selectedMonth;
                  },
                  builder: (context, state) {
                    bool isSelect = state.type == ManageFeedbackType.read;

                    return ChoiceChip(
                      onSelected: (value) {
                        context.read<FeedbackBloc>().add(
                              const FeedbackUpdateTypeEvent(
                                type: ManageFeedbackType.read,
                              ),
                            );
                      },
                      selected: isSelect,
                      label: const Text('Đã xem'),
                      checkmarkColor: AppColors.themeColor,
                      backgroundColor: isSelect ? null : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: isSelect
                            ? BorderSide.none
                            : BorderSide(color: Colors.grey[300]!),
                      ),
                      labelStyle: TextStyle(
                        color: isSelect ? AppColors.themeColor : Colors.grey,
                        fontSize: 13,
                      ),
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<FeedbackBloc, FeedbackState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const LoadingList();
                  }

                  if (state.feedback.isEmpty) {
                    return const EmptyFeedbackList();
                  }

                  DateTime nowTime = DateTime.now();
                  return ListView.separated(
                    itemCount: state.feedback.length,
                    padding: const EdgeInsets.only(top: 6),
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.grey[300],
                        height: 8,
                      );
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteSlideTransition(
                              child: ProductFeedbackPage(
                                productId: state.feedback[index].bookId,
                              ),
                            ),
                          );
                        },
                        child: FeedbackItem(
                          feedback: state.feedback[index],
                          now: nowTime,
                        ),
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
