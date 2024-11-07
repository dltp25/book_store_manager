import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/extensions/datetime_ex.dart';
import 'package:book_store_manager/models/notification_model.dart';
import 'package:book_store_manager/screens/order_details/order_details_page.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../bloc/notification_bloc.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notiModel;
  final DateTime nowTime;

  const NotificationItem({
    super.key,
    required this.notiModel,
    required this.nowTime,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<NotificationBloc>().add(
              ReadNotificationEvent(
                notiId: notiModel.id,
                isRead: !notiModel.isRead,
              ),
            );
        Navigator.of(context).push(
          PageRouteSlideTransition(
            child: OrderDetailsPage(orderId: notiModel.orderId),
          ),
        );
      },
      child: Container(
        height: 60 + 16,
        padding: const EdgeInsets.only(left: 4, top: 4, bottom: 4, right: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        notiModel.userAvatar,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          notiModel.status == 0
                              ? AppIcons.cartAddCreate
                              : notiModel.status == 4
                                  ? AppIcons.cartAddDone
                                  : AppIcons.cartAdd,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: statusText(notiModel.status),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                            color:
                                notiModel.isRead ? Colors.grey : Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: statusText2(
                                  notiModel.userName, notiModel.status),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      notiModel.date.displayTimeAgoFrom(nowTime),
                      style: TextStyle(
                        fontSize: 12,
                        color: notiModel.isRead ? Colors.grey : Colors.blue,
                        fontWeight: notiModel.isRead
                            ? FontWeight.normal
                            : FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(4),
            PopupMenuButton(
              icon: Icon(Icons.more_horiz, size: 20, color: Colors.grey[900]),
              padding: EdgeInsets.zero,
              iconSize: 20,
              position: PopupMenuPosition.under,
              color: Colors.black.withOpacity(0.8),
              constraints: const BoxConstraints(),
              elevation: 0,
              offset: const Offset(0, -4),
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              onSelected: (value) {
                if (value == 1) {
                  context.read<NotificationBloc>().add(
                        ReadNotificationEvent(
                            notiId: notiModel.id, isRead: !notiModel.isRead),
                      );
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    padding: const EdgeInsets.only(left: 8, right: 4),
                    height: 32,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check, size: 20, color: Colors.white),
                        const Gap(8),
                        Text(
                          notiModel.isRead
                              ? 'Đánh dấu là chưa đọc'
                              : 'Đánh dấu là đã đọc',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }

  String statusText(int status) {
    if (status == 0) {
      return "Đơn hàng vừa được tạo: ";
    } else if (status == 4) {
      return "Giao thành công: ";
    }
    return "Đơn hàng đã bị hủy: ";
  }

  String statusText2(String userName, int status) {
    if (status == 0) {
      return "$userName đã tạo một đơn hàng";
    } else if (status == 4) {
      return "$userName đã nhận hàng thành công";
    }
    return "$userName đã hủy một đơn hàng";
  }
}
