import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/auth/logic/register/register_cubit.dart';
import 'package:story_app/feature/auth/repository/auth_repository.dart';
import 'register_view.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/register');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(AuthRepositoryImpl.create()),
      child: const RegisterView(),
    );
  }
}
