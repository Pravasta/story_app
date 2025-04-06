import 'package:story_app/core/utils/app_transition.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static push(Widget child, RouteSettings settings) {
    return navigatorKey.currentState?.push(
      AppTransition.pushTransition(child, settings),
    );
  }

  static pop({Object? arguments}) {
    return navigatorKey.currentState?.pop(arguments);
  }

  static pushAndRemoveUntil(Widget child, RouteSettings settings) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      AppTransition.pushAndRemoveUntilTransition(child, settings),
      (route) => false,
    );
  }

  static pushReplacement(Widget child, RouteSettings settings) {
    return navigatorKey.currentState?.pushReplacement(
      AppTransition.pushTransition(child, settings),
    );
  }
}
