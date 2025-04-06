import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/core/injection/env.dart';
import 'package:story_app/core/logic/cubit/app_permissions_cubit.dart';
import 'package:story_app/core/repositories/app_permissions_repositories.dart';
import 'package:story_app/core/routes/app_route.dart';
import 'package:story_app/core/theme/app_theme.dart';

import 'feature/add_story/cubit/add_new_story/add_new_story_cubit.dart';
import 'feature/add_story/repository/add_story_repository.dart';
import 'feature/home/cubit/get_all_stories/get_all_stories_cubit.dart';
import 'feature/home/repository/home_repository.dart';

TextTheme appTextTheme(BuildContext context) => Theme.of(context).textTheme;
ColorScheme appColorScheme(BuildContext context) =>
    Theme.of(context).colorScheme;

const Environment env = Environment.development;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetAllStoriesCubit(HomeRepositoryImpl.create()),
        ),
        BlocProvider(
          create:
              (_) =>
                  AppPermissionsCubit(AppPermissionsRepositoriesImpl.create()),
        ),
        BlocProvider(
          create: (_) => AddNewStoryCubit(AddStoryRepositoryImpl.create()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Story App',
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        themeMode: ThemeMode.light,
        darkTheme: AppTheme.darkTheme(context),
        theme: AppTheme.lightTheme(context),
        routerConfig: AppRoute.route,
      ),
    );
  }
}
