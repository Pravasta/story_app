import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/splash/cubit/login_status/login_status_cubit.dart';
import 'package:story_app/feature/splash/repository/splash_repository.dart';
import 'package:story_app/feature/splash/view/splash_view.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              LoginStatusCubit(SplashRepositoryImpl.create())
                ..checkLoginStatus(),
      child: const SplashView(),
    );
  }
}
