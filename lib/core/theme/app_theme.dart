import 'package:story_app/core/theme/app_color.dart';
import 'package:story_app/core/theme/app_color_scheme.dart';
import 'package:story_app/core/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      textTheme: AppTextStyle.lightTextTheme,
      primaryColor: AppColor.primary,
      colorScheme: ApptColorScheme.light,
      scaffoldBackgroundColor: AppColor.black[50],
      appBarTheme: const AppBarTheme(
        elevation: 2,
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        shadowColor: AppColor.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColor.primary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColor.white,
        selectedItemColor: AppColor.black[900],
        unselectedItemColor: AppColor.neutral[400],
      ),
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      textTheme: AppTextStyle.darkTextTheme,
      primaryColor: AppColor.primary,
      colorScheme: ApptColorScheme.dark,
      scaffoldBackgroundColor: AppColor.primary,
      appBarTheme: const AppBarTheme(
        elevation: 2,
        backgroundColor: AppColor.primary,
        surfaceTintColor: AppColor.primary,
        shadowColor: AppColor.primary,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColor.primary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      ),
      useMaterial3: true,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColor.black[900],
        selectedItemColor: AppColor.white,
        unselectedItemColor: AppColor.neutral[400],
      ),
    );
  }
}
