import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/auth/repository/auth_repository.dart';
import '../../logic/login/login_cubit.dart';
import 'login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/login');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(AuthRepositoryImpl.create()),
      child: const LoginView(),
    );
  }
}
