import 'package:book_store_manager/extensions/datetime_ex.dart';
import 'package:book_store_manager/models/feedback_model.dart';
import '../bloc/feedback_hide_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FeedbackHideItem extends StatelessWidget {
  final FeedbackModel feedback;
  final DateTime now;

  const FeedbackHideItem({
    super.key,
    required this.feedback,
    required this.now,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60 + 16,
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(feedback.userAvatar),
              ),
            ),
          ),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  TextSpan(
                    text: feedback.userName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    children: [
                      const TextSpan(
                        text: ' đã đánh giá ',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: '${feedback.rating.toStringAsFixed(0)} sao',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Gap(2),
                ExpandableText(
                  feedback.review,
                  expandText: 'Xem thêm',
                  collapseText: 'Ẩn bớt',
                  maxLines: 1,
                  linkColor: Colors.blue,
                  style: const TextStyle(
                      fontSize: 12, fontStyle: FontStyle.italic),
                ),
                if (feedback.isReply)
                  Column(
                    children: [
                      const Gap(4),
                      Text.rich(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                          text: 'Shop: ',
                          style: const TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: feedback.adminReply,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue[300]!,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Text(
                      feedback.dateSubmit.displayTimeAgoFrom(now),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                      icon: const Icon(Icons.more_horiz, size: 16),
                      padding: EdgeInsets.zero,
                      position: PopupMenuPosition.under,
                      color: Colors.black.withOpacity(0.8),
                      elevation: 0,
                      offset: const Offset(0, -4),
                      surfaceTintColor: Colors.white,
                      onSelected: (value) {
                        if (value == 1) {
                          context.read<FeedbackHideBloc>().add(
                                FeedbackUnHideEvent(feedbackId: feedback.id),
                              );
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            value: 1,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            height: 32,
                            child: Text(
                              'Khôi phục bình luận',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
