import 'package:story_app/core/injection/env.dart';
import 'package:story_app/main.dart';

class Injection {
  static const String fontFamily = 'Poppins';
  static final String baseURL = env.baseURL;
  static final bool isDevelopment = env.isDevelopMode;
}
