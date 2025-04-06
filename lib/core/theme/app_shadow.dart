import 'package:flutter/material.dart';
import 'package:story_app/core/theme/app_color.dart';

class AppBoxShadow {
  List<BoxShadow> small = [
    BoxShadow(
      color: AppColor.black.withOpacity(0.05),
      offset: const Offset(0, 1),
      blurRadius: 2.0,
      spreadRadius: 0.0,
    ),
  ];

  List<BoxShadow> normal = [
    BoxShadow(
      color: AppColor.black.withOpacity(0.1),
      offset: const Offset(0, 1),
      blurRadius: 3.0,
      spreadRadius: 0.0,
    ),
    BoxShadow(
      color: AppColor.black.withOpacity(0.1),
      offset: const Offset(0, 1),
      blurRadius: 2.0,
      spreadRadius: -1.0,
    ),
  ];

  List<BoxShadow> medium = [
    BoxShadow(
      color: AppColor.black.withOpacity(0.1),
      offset: const Offset(0, 4),
      blurRadius: 6.0,
      spreadRadius: -1.0,
    ),
    BoxShadow(
      color: AppColor.black.withOpacity(0.1),
      offset: const Offset(0, 2),
      blurRadius: 4.0,
      spreadRadius: -2.0,
    ),
  ];

  List<BoxShadow> large = [
    BoxShadow(
      color: AppColor.black.withOpacity(0.1),
      offset: const Offset(0, 10),
      blurRadius: 15.0,
      spreadRadius: -3.0,
    ),
    BoxShadow(
      color: AppColor.black.withOpacity(0.1),
      offset: const Offset(0, 4),
      blurRadius: 6.0,
      spreadRadius: -4.0,
    ),
  ];

  List<BoxShadow> extraLarge = [
    BoxShadow(
      color: AppColor.black.withOpacity(0.1),
      offset: const Offset(0, 20),
      blurRadius: 25.0,
      spreadRadius: -5.0,
    ),
    BoxShadow(
      color: AppColor.black.withOpacity(0.1),
      offset: const Offset(0, 8),
      blurRadius: 10.0,
      spreadRadius: -6.0,
    ),
  ];

  List<BoxShadow> doubleExtraLarge = [
    BoxShadow(
      color: AppColor.black.withOpacity(0.25),
      offset: const Offset(0, 25),
      blurRadius: 50.0,
      spreadRadius: -12.0,
    ),
  ];

  List<BoxShadow> inner = [
    BoxShadow(
      color: AppColor.black.withOpacity(0.05),
      offset: const Offset(0, 2),
      blurRadius: 4.0,
      spreadRadius: 0.0,
    ),
  ];
}
