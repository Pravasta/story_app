import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/settings/cubit/logout/logout_cubit.dart';
import 'package:story_app/feature/settings/repository/settings_repository.dart';
import 'settings_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/settings');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LogoutCubit(SettingsRepositoryImpl.create()),
        ),
      ],
      child: SettingsView(),
    );
  }
}
