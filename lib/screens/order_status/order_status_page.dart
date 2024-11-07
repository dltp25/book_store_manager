import 'package:book_store_manager/repositories/repository.dart';
import 'delivering/bloc/delivering_order_bloc.dart' as p3;
import 'prepared/bloc/prepared_order_bloc.dart' as p1;
import 'views/order_status_tab.dart';
import '../../constant/app_icons.dart';
import 'preparing/bloc/preparing_order_bloc.dart' as p2;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delivering/order_delivering_page.dart';
import 'prepared/order_prepared_page.dart';
import 'preparing/order_preparing_page.dart';
import 'package:flutter/material.dart';

import '../../themes/colors.dart';
import '../../widgets/custom_app_bar.dart';

class OrderStatusPage extends StatefulWidget {
  final int tabIndex;

  const OrderStatusPage({super.key, required this.tabIndex});

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.tabIndex,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => p2.PreparingOrderBloc(
            RepositoryProvider.of<AppRepository>(context).orderRepository,
          )..add(p2.InitialEvent()),
        ),
        BlocProvider(
          create: (context) => p1.PreparedOrderBloc(
            RepositoryProvider.of<AppRepository>(context).orderRepository,
          )..add(p1.InitialEvent()),
        ),
        BlocProvider(
          create: (context) => p3.DeliveringOrderBloc(
            RepositoryProvider.of<AppRepository>(context).orderRepository,
          )..add(p3.InitialEvent()),
        )
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: 'Theo dõi đơn hàng',
          color: Colors.orangeAccent[700]!,
          imgBg: AppIcons.orderFill,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: AppColors.themeColor,
                unselectedLabelColor: Colors.grey[400],
                padding: EdgeInsets.zero,
                tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.themeColor,
                      width: 2,
                    ),
                  ),
                ),
                tabs: [
                  BlocBuilder<p2.PreparingOrderBloc, p2.PreparingOrderState>(
                    builder: (context, state) {
                      return OrderStatusTab(
                        title: 'Đang chuẩn bị',
                        count: state.preparingOrders.length,
                      );
                    },
                  ),
                  BlocBuilder<p1.PreparedOrderBloc, p1.PreparedOrderState>(
                    builder: (context, state) {
                      return OrderStatusTab(
                        title: 'Chuẩn bị xong',
                        count: state.preparedOrders.length,
                      );
                    },
                  ),
                  BlocBuilder<p3.DeliveringOrderBloc, p3.DeliveringOrderState>(
                    builder: (context, state) {
                      return OrderStatusTab(
                        title: 'Đang vận chuyển',
                        count: state.deliveringOrders.length,
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  OrderPreparingPage(),
                  OrderPreparedPage(),
                  OrderDeliveringPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
