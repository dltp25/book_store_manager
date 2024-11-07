import 'notification_item.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'empty_page.dart';
import 'package:book_store_manager/widgets/loading/loading_list.dart';

import '../bloc/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingList();
        }

        if (state.notis.isEmpty) {
          return const EmptyNotificationPage();
        }

        DateTime now = DateTime.now();
        return ListView.builder(
          itemCount: state.notis.length == state.number
              ? state.number + 1
              : state.notis.length,
          controller: _controller,
          itemBuilder: (context, index) {
            if (index == state.number) {
              return Center(
                child: LoadingAnimationWidget.threeRotatingDots(
                  color: AppColors.themeColor,
                  size: 30,
                ),
              );
            }

            return NotificationItem(
              notiModel: state.notis[index],
              nowTime: now,
            );
          },
        );
      },
    );
  }

  void onScroll() {
    if (isBottom &&
        context.read<NotificationBloc>().state.notis.length ==
            context.read<NotificationBloc>().state.number) {
      context.read<NotificationBloc>().add(LoadMoreNotiEvent());
    }
  }

  bool get isBottom {
    if (!_controller.hasClients) return false;
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.offset;
    return currentScroll == maxScroll;
  }
}
