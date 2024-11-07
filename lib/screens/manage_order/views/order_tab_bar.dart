import '../bloc/manage_order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/app_fonts.dart';
import '../../../themes/colors.dart';

class OrderTabBar extends StatelessWidget {
  final TabController tabController;
  const OrderTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: TabBar(
        controller: tabController,
        isScrollable: false,
        labelColor: AppColors.themeColor,
        splashBorderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: AppFonts.averta,
          fontSize: 14,
        ),
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontFamily: AppFonts.averta,
        ),
        labelPadding: EdgeInsets.zero,
        indicatorWeight: 0,
        indicator: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        tabs: [
          BlocBuilder<ManageOrderBloc, ManageOrderState>(
            buildWhen: (previous, current) {
              return previous.expressOrders.length !=
                  current.expressOrders.length;
            },
            builder: (context, state) {
              return customTab('Hỏa tốc', state.expressOrders.length);
            },
          ),
          BlocBuilder<ManageOrderBloc, ManageOrderState>(
            buildWhen: (previous, current) {
              return previous.fastOrders.length != current.fastOrders.length;
            },
            builder: (context, state) {
              return customTab('Nhanh', state.fastOrders.length);
            },
          ),
          BlocBuilder<ManageOrderBloc, ManageOrderState>(
            buildWhen: (previous, current) {
              return previous.basicOrders.length != current.basicOrders.length;
            },
            builder: (context, state) {
              return customTab('Cơ bản', state.basicOrders.length);
            },
          ),
        ],
      ),
    );
  }

  Widget customTab(String title, int length) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Badge(
        isLabelVisible: length != 0,
        padding: EdgeInsets.zero,
        label: SizedBox(
          height: 16,
          width: 16,
          child: Center(child: Text(length.toStringAsFixed(0))),
        ),
        backgroundColor: AppColors.themeColor,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
