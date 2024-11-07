import 'package:book_store_manager/models/user_report_model.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/utils/date_time.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../bloc/user_report_bloc.dart';

class ReportItem extends StatelessWidget {
  final UserReportModel reportModel;

  const ReportItem({super.key, required this.reportModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red[100],
                ),
                child: Text(
                  reportModel.report,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: Colors.red[600]!),
                ),
              ),
              Text(
                DateTimeUtils.feedbackTime(reportModel.date),
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          const Gap(6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      reportModel.feedbackAvatar,
                    ),
                  ),
                ),
              ),
              const Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reportModel.feedbackUserName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          children: [
                            for (int i = 0; i < reportModel.feedbackRating; i++)
                              const Icon(Icons.star,
                                  size: 14, color: Colors.amber),
                          ],
                        ),
                      ],
                    ),
                    const Gap(2),
                    ExpandableText(
                      reportModel.feedbackReview,
                      expandText: 'Xem thêm',
                      collapseText: 'Ẩn bớt',
                      maxLines: 1,
                      linkColor: Colors.blue,
                      style: const TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(6),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 32,
                child: TextButton(
                  onPressed: () {
                    context.read<UserReportBloc>().add(
                          ReadReportEvent(reportId: reportModel.id),
                        );
                  },
                  child: const Text(
                    'Bỏ qua',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const Gap(6),
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<UserReportBloc>().add(
                          HideFeedbackEvent(feedbackId: reportModel.feedbackId),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor.withOpacity(0.1),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    'Ẩn đánh giá',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.themeColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
