import 'package:book_store_manager/repositories/repository.dart';
import 'package:book_store_manager/screens/home/bloc/home_bloc.dart';
import 'package:book_store_manager/screens/home/home_page.dart';

import 'require_sign_out_page.dart';
import 'package:book_store_manager/widgets/loading/home_loading_page.dart';

import '../../repositories/services/authentication/authentication_service.dart';
import 'bloc/root_bloc.dart';
import '../login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthenticationService.authState(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          BlocProvider.of<RootBloc>(context).add(
            ValidateAuthEvent(uid: snapshot.data!.uid),
          );
          return _RootContent();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

class _RootContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RootBloc, RootState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.isLoading) {
          return const HomeLoadingPage();
        }

        if (state.isAdmin) {
          return BlocProvider(
            create: (context) => HomeBloc(
              RepositoryProvider.of<AppRepository>(context).orderRepository,
            )..add(HomeLoading()),
            child: const HomePage(),
          );
        }

        return const RequireSignOutPage();
      },
    );
  }
}
