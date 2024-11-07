import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/repositories/repository.dart';
import '../import_product_create/create_import_product_page.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import 'views/import_history_item.dart';
import 'package:book_store_manager/widgets/empty_import_list.dart';
import 'package:book_store_manager/widgets/loading/loading_list.dart';
import 'bloc/import_product_bloc.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'views/calendar_button.dart';

class ImportProductPage extends StatelessWidget {
  const ImportProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImportProductBloc(
        RepositoryProvider.of<AppRepository>(context).importRepository,
      )..add(LoadImportProductHistory(time: DateTime.now())),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: 'Nhập hàng',
          color: Colors.orangeAccent[700]!,
          imgBg: AppIcons.add,
        ),
        floatingActionButton: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteSlideTransition(
                    child: const CreateImportProductPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              backgroundColor: Colors.orangeAccent[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nhập hàng',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(4),
                Icon(Icons.add, color: Colors.white),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
              child: Row(
                children: [
                  Text(
                    'Lịch sử nhập hàng',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text('Tháng: ', style: TextStyle(fontSize: 13)),
                  CalendarButton(),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ImportProductBloc, ImportProductState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const LoadingList();
                  }

                  if (state.history.isEmpty) {
                    return const EmptyImportList();
                  }

                  return ListView.separated(
                    itemCount: state.history.length,
                    padding: EdgeInsets.only(
                      bottom: 56 + MediaQuery.of(context).padding.bottom,
                    ),
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColors.background,
                        thickness: 4,
                        height: 4,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ImportHistoryItem(
                        importProductModel: state.history[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
