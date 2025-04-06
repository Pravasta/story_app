import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/routes/routes_name.dart';
import 'package:story_app/feature/splash/cubit/login_status/login_status_cubit.dart';
import 'package:story_app/main.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginStatusCubit, LoginStatusState>(
      listener: (context, state) {
        if (state.status == LoginStatus.authenticated) {
          context.go(RoutesName.mainPage);
        }
        if (state.status == LoginStatus.unauthenticated) {
          context.go(RoutesName.login);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Story App', style: appTextTheme(context).displayMedium),
                SizedBox(height: 20),
                Text(
                  'Welcome to Story App, \n you can create every story you want',
                  textAlign: TextAlign.center,
                  style: appTextTheme(
                    context,
                  ).bodyLarge!.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
