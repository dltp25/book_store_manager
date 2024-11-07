import 'package:book_store_manager/repositories/repository.dart';
import '../../constant/app_icons.dart';
import '../../themes/texts.dart';
import '../user_order_history/user_order_history_page.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import 'views/user_information.dart';
import 'views/user_orders_list.dart';
import 'bloc/user_details_bloc.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../models/user_model.dart';
import 'views/user_statistic_item.dart';
import 'package:flutter/material.dart';

class UserDetailsPage extends StatelessWidget {
  final UserModel user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDetailsBloc(
        RepositoryProvider.of<AppRepository>(context).userRepository,
        RepositoryProvider.of<AppRepository>(context).orderRepository,
      )..add(InitialEvent(userId: user.userId)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                elevation: 0,
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.white,
                title: Text('Khách hàng', style: AppTexts.appbarTitle),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orangeAccent[700]!,
                        Colors.orangeAccent[700]!.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    image: DecorationImage(
                      image: AssetImage(AppIcons.userGroupFill),
                      opacity: 0.2,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(user.avatar),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    BlocBuilder<UserDetailsBloc, UserDetailsState>(
                      buildWhen: (previous, current) {
                        return previous.totalOrders != current.totalOrders;
                      },
                      builder: (context, state) {
                        return UserStatisticItem(
                          value: state.totalOrders.toStringAsFixed(0),
                          title: 'Đơn đã đặt',
                        );
                      },
                    ),
                    BlocBuilder<UserDetailsBloc, UserDetailsState>(
                      buildWhen: (previous, current) {
                        return previous.orders != current.orders;
                      },
                      builder: (context, state) {
                        return UserStatisticItem(
                          value: state.orders.length.toStringAsFixed(0),
                          title: 'Đang chờ',
                        );
                      },
                    ),
                    BlocBuilder<UserDetailsBloc, UserDetailsState>(
                      buildWhen: (previous, current) {
                        return previous.completeOrders !=
                            current.completeOrders;
                      },
                      builder: (context, state) {
                        return UserStatisticItem(
                          value: state.completeOrders.toStringAsFixed(0),
                          title: 'Đơn xong',
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserInformation(user: user),
                    const Gap(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Danh sách đơn chờ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 38,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteSlideTransition(
                                  child: UserOrderHistoryPage(user: user),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 4,
                              ),
                              foregroundColor: AppColors.themeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.themeColor,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Lịch sử mua hàng',
                                    style: TextStyle(
                                      color: AppColors.themeColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_double_arrow_right,
                                    color: AppColors.themeColor,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Expanded(child: UserOrderList()),
            ],
          ),
        ),
      ),
    );
  }
}
