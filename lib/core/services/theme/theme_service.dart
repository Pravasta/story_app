import '../../local_storage/shared_pref_key.dart';
import '../../local_storage/shared_pref_service.dart';

abstract class ThemeService {
  Future<void> setTheme(bool isDarkMode);
  Future<bool?> getTheme();
}

class ThemeServiceImpl implements ThemeService {
  final SharedPrefService _sharedPrefService;

  ThemeServiceImpl({required SharedPrefService sharedPrefService})
    : _sharedPrefService = sharedPrefService;

  @override
  Future<void> setTheme(bool isDarkMode) async {
    await _sharedPrefService.setBoolSharedPref(
      AppSharedPrefKey.isDarkMode,
      isDarkMode,
    );
  }

  @override
  Future<bool?> getTheme() async {
    return await _sharedPrefService.getBoolSharedPref(
      AppSharedPrefKey.isDarkMode,
    );
  }

  factory ThemeServiceImpl.create() {
    return ThemeServiceImpl(sharedPrefService: SharedPrefServiceImpl.create());
  }
}
