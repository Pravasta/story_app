import 'package:flutter/material.dart';

class AppColor {
  static const neutral = MaterialColor(0xff4B5563, <int, Color>{
    50: Color(0xFFF9FAFB),
    100: Color(0xFFF3F4F6),
    200: Color(0xFFE5E7EB),
    300: Color(0xFFD1D5DB),
    400: Color(0xFF9CA3AF),
    500: Color(0xFF6B7280),
    600: Color(0xFF4B5563),
    700: Color(0xFF374151),
    800: Color(0xFF1F2937),
    900: Color(0xFF111827),
  });

  static const accent = MaterialColor(0xffF9B091, <int, Color>{
    50: Color(0xFFFFF2F0),
    100: Color(0xFFFFE6DC),
    200: Color(0xFFFFD6C2),
    300: Color(0xFFFFC6A8),
    400: Color(0xFFFFB89A),
    500: Color(0xFFF9B091),
    600: Color(0xFFF8A78A),
    700: Color(0xFFF69D7F),
    800: Color(0xFFF49375),
    900: Color(0xFFF18363),
  });

  static const black = MaterialColor(0xff000000, <int, Color>{
    50: Color(0xFFF9FAFB),
    100: Color(0xFFF3F4F6),
    200: Color(0xFFE5E7EB),
    300: Color(0xFFD1D5DB),
    400: Color(0xFF9CA3AF),
    500: Color(0xFF6B7280),
    600: Color(0xFF4B5563),
    700: Color(0xFF374151),
    800: Color(0xFF1F2937),
    900: Color(0xff000000),
  });

  static const MaterialColor primary = MaterialColor(0xff040c23, <int, Color>{
    50: Color(0xFFE6D9FF),
    100: Color(0xFF863ED5),
    200: Color(0xFF040c23),
    300: Color(0xFF040c23),
    400: Color(0xFF040c23),
    500: Color(0xFF040c23),
    600: Color(0xFF040c23),
    700: Color(0xFF040c23),
    800: Color(0xFF040c23),
    900: Color(0xFF121930),
  });

  static const MaterialColor primaryAccent =
      MaterialColor(0xff863ED5, <int, Color>{
        100: Color(0xFFDF98FA),
        200: Color(0xFF863ED5),
        400: Color(0xFF9055FF),
        700: Color(0xFF808CFF),
      });

  static const MaterialColor secondary = MaterialColor(0xFFF9AA68, <int, Color>{
    50: Color(0xFFFEF5ED),
    100: Color(0xFFFDE6D2),
    200: Color(0xFFFCD5B4),
    300: Color(0xFFFBC495),
    400: Color(0xFFFAB77F),
    500: Color(0xFFF9AA68),
    600: Color(0xFFF8A360),
    700: Color(0xFFF79955),
    800: Color(0xFFF6904B),
    900: Color(0xFFF57F3A),
  });

  static const MaterialColor secondaryAccent =
      MaterialColor(0xFFF9AA68, <int, Color>{
        100: Color(0xFFFFFFFF),
        200: Color(0xFFF9AA68),
        400: Color(0xFFFFE6D9),
        700: Color(0xFFFFD6BF),
      });

  static const white = Color(0xFFFFFFFF);
  static const transparent = Colors.transparent;
}
