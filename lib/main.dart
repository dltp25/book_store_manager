import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/firebase_options.dart';
import 'package:book_store_manager/repositories/repository.dart';
import 'package:book_store_manager/screens/logging/bloc/logging_bloc.dart';
import 'package:book_store_manager/screens/notification/bloc/notification_bloc.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/root/bloc/root_bloc.dart';
import 'screens/root/root_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => RootBloc()),
          BlocProvider(
            create: (context) => NotificationBloc(
              RepositoryProvider.of<AppRepository>(context).notiRepository,
              RepositoryProvider.of<AppRepository>(context).userRepository,
            )..add(const LoadNotificationEvent(type: NotiViewType.all)),
          ),
          BlocProvider(
            create: (context) => LoggingBloc()..add(InitialEvent()),
          )
        ],
        child: MaterialApp(
          title: 'IBOO Manager',
          debugShowCheckedModeBanner: false,
          navigatorKey: DialogUtils.navigatorKey,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.themeColor),
            useMaterial3: true,
            fontFamily: 'Averta',
          ),
          home: const RootPage(),
        ),
      ),
    );
  }
}
