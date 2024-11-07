import 'package:book_store_manager/models/feedback_model.dart';
import '../bloc/product_feedback_bloc.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/utils/date_time.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:gap/gap.dart';

class ProductFeedbackItem extends StatelessWidget {
  final FeedbackModel feedback;

  const ProductFeedbackItem({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(feedback.userAvatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const Gap(6),
              Icon(
                feedback.isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                color:
                    feedback.isLiked ? Colors.orangeAccent[700] : Colors.grey,
                size: 14,
              ),
              const Gap(12),
              CustomPopup(
                content: GestureDetector(
                  onTap: () {
                    context
                        .read<ProductFeedbackBloc>()
                        .add(ProductHideFeedback(feedbackId: feedback.id));
                  },
                  child: const Text(
                    'Ẩn bình luận',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                backgroundColor: Colors.black.withOpacity(0.8),
                arrowColor: Colors.black.withOpacity(0.8),
                barrierColor: Colors.transparent,
                child: const Icon(
                  Icons.more_horiz,
                  size: 14,
                  color: Colors.grey,
                ),
              ),
              const Gap(12),
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
                  linkColor: AppColors.themeColor,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ),
            ],
          ),
          if (feedback.isReply)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
        ],
      ),
    );
  }
}
