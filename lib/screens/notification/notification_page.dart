import 'package:book_store_manager/constant/enum.dart';
import 'views/notifications_list.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'bloc/notification_bloc.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Thông báo',
        color: Colors.orangeAccent[700]!,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
            child: Row(
              children: [
                BlocBuilder<NotificationBloc, NotificationState>(
                  buildWhen: (previous, current) {
                    return previous.viewType != current.viewType ||
                        previous.number != current.number;
                  },
                  builder: (context, state) {
                    bool isSelect = state.viewType == NotiViewType.all;

                    return ChoiceChip(
                      onSelected: (value) {
                        context.read<NotificationBloc>().add(
                              const LoadNotificationEvent(
                                type: NotiViewType.all,
                              ),
                            );
                      },
                      label: const Text('Tất cả'),
                      labelStyle: TextStyle(
                        color: isSelect ? Colors.blue[900]! : Colors.black,
                        fontWeight:
                            isSelect ? FontWeight.w600 : FontWeight.normal,
                      ),
                      selected: isSelect,
                      selectedColor: Colors.blue[100],
                      checkmarkColor: Colors.blue,
                      side: BorderSide.none,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    );
                  },
                ),
                const Gap(4),
                BlocBuilder<NotificationBloc, NotificationState>(
                  buildWhen: (previous, current) {
                    return previous.viewType != current.viewType ||
                        previous.number != current.number;
                  },
                  builder: (context, state) {
                    bool isSelect = state.viewType == NotiViewType.unRead;

                    return ChoiceChip(
                      onSelected: (value) {
                        context.read<NotificationBloc>().add(
                              const LoadNotificationEvent(
                                type: NotiViewType.unRead,
                              ),
                            );
                      },
                      label: const Text('Chưa đọc'),
                      labelStyle: TextStyle(
                        color: isSelect ? Colors.blue[900]! : Colors.black,
                        fontWeight:
                            isSelect ? FontWeight.w600 : FontWeight.normal,
                      ),
                      selected: isSelect,
                      selectedColor: Colors.blue[100],
                      checkmarkColor: Colors.blue,
                      surfaceTintColor: Colors.white,
                      side: BorderSide.none,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mới',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    context.read<NotificationBloc>().add(MarkAllAsReadEvent());
                  },
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check, size: 16, color: Colors.blue),
                      Gap(2),
                      Text(
                        'Đánh dấu tất cả là đã đọc',
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: NotificationList()),
        ],
      ),
    );
  }
}
