import '../services/theme/theme_service.dart';

abstract class ThemeRepositories {
  Future<void> setTheme(bool isDarkMode);
  Future<bool?> getTheme();
}

class ThemeRepositoriesImpl implements ThemeRepositories {
  final ThemeService _themeService;

  ThemeRepositoriesImpl({required ThemeService themeService})
    : _themeService = themeService;

  @override
  Future<void> setTheme(bool isDarkMode) async {
    await _themeService.setTheme(isDarkMode);
  }

  @override
  Future<bool?> getTheme() async {
    return await _themeService.getTheme();
  }

  factory ThemeRepositoriesImpl.create() {
    return ThemeRepositoriesImpl(themeService: ThemeServiceImpl.create());
  }
}
