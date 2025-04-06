import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/routes/navigation.dart';
import 'package:story_app/core/routes/routes_name.dart';
import 'package:story_app/feature/add_story/view/camera_page.dart';
import 'package:story_app/feature/add_story/view/preview_story_page.dart';
import 'package:story_app/feature/add_story/view/add_story_page.dart';
import 'package:story_app/feature/auth/view/login/login_page.dart';
import 'package:story_app/feature/auth/view/register/register_page.dart';
import 'package:story_app/feature/detail_story/view/detail_story_page.dart';
import 'package:story_app/feature/settings/view/settings_page.dart';
import 'package:story_app/feature/splash/view/main_page.dart';
import 'package:story_app/feature/splash/view/splash_page.dart';

import '../model/request/preview_story_request_model.dart';

class AppRoute {
  static final route = GoRouter(
    navigatorKey: navigatorKey,
    routerNeglect: true,
    debugLogDiagnostics: true,
    initialLocation: RoutesName.initial,
    routes: [
      _customPageRoute(RoutesName.initial, SplashPage()),

      _customPageRoute(RoutesName.login, LoginPage()),

      _customPageRoute(RoutesName.register, RegisterPage()),

      _customPageRoute(RoutesName.mainPage, MainPage()),

      _customPageRoute(RoutesName.settings, SettingsPage()),

      _customPageRoute(RoutesName.addPost, AddStoryPage()),

      _customPageRoute(
        '${RoutesName.detailPost}/:storyId',
        null,
        builder: (context, state) {
          final storyId = state.pathParameters['storyId'];
          return DetailStoryPage(storyId: storyId ?? '');
        },
      ),

      _customPageRoute(
        RoutesName.addDetailPost,
        null,
        builder: (context, state) {
          final data = state.extra as PreviewStoryRequestModel;
          return PreviewStoryPage(data: data);
        },
      ),

      _customPageRoute(RoutesName.cameraPage, CameraPage()),
    ],
  );

  static GoRoute _customPageRoute(
    String path,
    Widget? child, {
    List<GoRoute>? routes,
    Widget Function(BuildContext, GoRouterState)? builder,
  }) {
    return GoRoute(
      path: path,
      routes: routes ?? [],
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: builder != null ? builder(context, state) : child!,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (path == RoutesName.addPost) {
              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
                child: child,
              );
            }

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    );
  }
}
