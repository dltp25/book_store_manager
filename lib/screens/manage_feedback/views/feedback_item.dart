import 'package:book_store_manager/models/feedback_model.dart';
import 'package:book_store_manager/utils/converter.dart';
import 'package:book_store_manager/utils/date_time.dart';
import 'reply_bottom_sheet.dart';
import '../bloc/feedback_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FeedbackItem extends StatelessWidget {
  final FeedbackModel feedback;
  final DateTime now;

  const FeedbackItem({super.key, required this.feedback, required this.now});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    image: CachedNetworkImageProvider(feedback.userAvatar),
                  ),
                ),
              ),
              const Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feedback.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < feedback.rating; i++)
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                DateTimeUtils.feedbackTime(feedback.dateSubmit),
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const Gap(4),
          Row(
            children: [
              const SizedBox(width: 32),
              Expanded(
                child: ExpandableText(
                  feedback.review,
                  expandText: 'Xem thêm',
                  collapseText: 'Ẩn bớt',
                  maxLines: 2,
                  linkColor: Colors.blue,
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: feedback.isRead ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            ],
          ),
          if (feedback.isReply)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: const EdgeInsets.only(top: 4),
              width: double.infinity,
              color: const Color(0xfff5f5f5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phản hồi của Người bán',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  const Gap(2),
                  Text(
                    feedback.adminReply,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff595959),
                    ),
                  ),
                ],
              ),
            ),
          const Gap(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (feedback.isReply == false)
                SizedBox(
                  height: 32,
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        builder: (newContext) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(newContext).viewInsets.bottom,
                            ),
                            child: ReplyBottomSheet(feedback: feedback),
                          );
                        },
                      ).then((value) {
                        if (value != null) {
                          value as Map<String, String>;

                          context.read<FeedbackBloc>().add(
                                FeedbackReplyEvent(
                                  feedbackId: feedback.id,
                                  reply: cvToString(value['reply']),
                                ),
                              );
                        }
                      });
                    },
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: const Icon(Icons.reply_outlined, size: 16),
                  ),
                ),
              SizedBox(
                height: 32,
                child: IconButton(
                  onPressed: () {
                    context.read<FeedbackBloc>().add(
                          FeedbackLikeEvent(
                            feedbackId: feedback.id,
                            isLike: !feedback.isLiked,
                          ),
                        );
                  },
                  style: IconButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: Icon(
                    feedback.isLiked
                        ? Icons.thumb_up
                        : Icons.thumb_up_alt_outlined,
                    color: feedback.isLiked ? Colors.blue : null,
                    size: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
                child: PopupMenuButton(
                  icon: const Icon(Icons.more_horiz, size: 16),
                  padding: EdgeInsets.zero,
                  position: PopupMenuPosition.under,
                  color: Colors.black.withOpacity(0.8),
                  elevation: 0,
                  offset: const Offset(0, -4),
                  surfaceTintColor: Colors.white,
                  onSelected: (value) {
                    if (value == 1) {
                      context.read<FeedbackBloc>().add(
                            FeedbackReadEvent(
                              feedbackId: feedback.id,
                              isRead: !feedback.isRead,
                            ),
                          );
                    } else if (value == 2) {
                      context
                          .read<FeedbackBloc>()
                          .add(FeedbackHideEvent(feedbackId: feedback.id));
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 32,
                        child: Text(
                          feedback.isRead
                              ? 'Đánh dấu là chưa xem'
                              : 'Đánh dấu là đã xem',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        height: 32,
                        child: Text(
                          'Ẩn bình luận',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
