import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/screens/home/bloc/home_bloc.dart';
import 'package:book_store_manager/utils/currency_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/statistic_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeStatistic extends StatelessWidget {
  const HomeStatistic({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 70,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Row(
              children: [
                StatisticItem(
                  title: 'Đơn',
                  content: state.isLoading
                      ? "-/-"
                      : state.homeStatistic!.totalOrder.toString(),
                  imgPath: AppIcons.order,
                ),
                const Gap(4),
                StatisticItem(
                  title: 'Đơn xong',
                  content: state.isLoading
                      ? "-/-"
                      : state.homeStatistic!.completeOrder.toString(),
                  color: Colors.lightBlueAccent[700],
                  imgPath: AppIcons.complete,
                ),
                const Gap(4),
                StatisticItem(
                  title: 'Doanh thu',
                  content: state.isLoading
                      ? "-/-"
                      : CurrencyUtils.convertDoubletoKMB(
                          state.homeStatistic!.revenue),
                  color: Colors.amber[700],
                  imgPath: AppIcons.coin,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String calcuteCompleteRate(int total, int complete) {
    if (total == 0) {
      return "100%";
    }
    return "${(complete * 100 / total).toStringAsFixed(1)}%";
  }
}
