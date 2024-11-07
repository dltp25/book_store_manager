import 'package:book_store_manager/constant/app_icons.dart';
import 'package:book_store_manager/repositories/repository.dart';
import 'package:book_store_manager/screens/manage_user/bloc/manage_user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/total_user.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'views/user_list.dart';
import 'views/user_search_field.dart';
import 'package:book_store_manager/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ManageUserPage extends StatelessWidget {
  const ManageUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageUserBloc(
        RepositoryProvider.of<AppRepository>(context).userRepository,
      )..add(InitialEvent()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: 'Quản lý khách hàng',
          imgBg: AppIcons.userGroupFill,
          color: Colors.orangeAccent[700]!,
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(12),
            UserSearchField(),
            Gap(12),
            TotalUser(),
            Gap(6),
            Expanded(child: UserList()),
          ],
        ),
      ),
    );
  }
}
