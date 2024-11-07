import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/repositories/repository.dart';
import 'package:book_store_manager/screens/order_done/order_done_page.dart';
import 'package:book_store_manager/screens/order_status/order_status_page.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import 'views/basic_orders.dart';
import 'views/express_orders.dart';
import 'views/fast_orders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/manage_order_bloc.dart';
import 'views/sort_dropdown_button.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'views/order_tab_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'views/order_status_item.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ManageOrderPage extends StatefulWidget {
  const ManageOrderPage({super.key});

  @override
  State<ManageOrderPage> createState() => _ManageOrderPageState();
}

class _ManageOrderPageState extends State<ManageOrderPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ManageOrderBloc(
            RepositoryProvider.of<AppRepository>(context).orderRepository,
          )..add(LoadingEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: 'Quản lý đơn hàng',
          imgBg: AppIcons.orderFill,
          color: Colors.orangeAccent[700]!,
          // color: Colors.purpleAccent[700]!,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(12),
                  const Text(
                    'Theo dõi đơn hàng',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const Gap(6),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      OrderStatusItem(
                        icon: MdiIcons.cartArrowDown,
                        title: "Đang chuẩn bị",
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteSlideTransition(
                              child: const OrderStatusPage(tabIndex: 0),
                            ),
                          );
                        },
                      ),
                      const Gap(6),
                      OrderStatusItem(
                        icon: MdiIcons.cartCheck,
                        title: "Chuẩn bị xong",
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteSlideTransition(
                              child: const OrderStatusPage(tabIndex: 1),
                            ),
                          );
                        },
                      ),
                      const Gap(6),
                      OrderStatusItem(
                        icon: MdiIcons.truckFastOutline,
                        title: "Đang vận chuyển",
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteSlideTransition(
                              child: const OrderStatusPage(tabIndex: 2),
                            ),
                          );
                        },
                      ),
                      const Gap(6),
                      OrderStatusItem(
                        icon: MdiIcons.clipboardCheckOutline,
                        title: "Đơn đã xong",
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteSlideTransition(
                              child: const OrderDonePage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Gap(12),
                  SizedBox(
                    height: 42,
                    child: Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<ManageOrderBloc, ManageOrderState>(
                            builder: (context, state) {
                              return Text(
                                state.isLoading
                                    ? 'Đơn chờ duyệt'
                                    : 'Đơn chờ duyệt (${state.orders.length.toStringAsFixed(0)})',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ),
                        const Text(
                          'Sắp xếp: ',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SortDropdownButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            OrderTabBar(tabController: tabController),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  ExpressOrders(),
                  FastOrders(),
                  BasicOrders(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
