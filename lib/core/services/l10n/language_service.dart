import 'package:story_app/core/local_storage/shared_pref_service.dart';

import '../../local_storage/shared_pref_key.dart';

abstract class LanguageService {
  Future<void> setLanguage(String languageCode);
  Future<String?> getLanguage();
}

class LanguageServiceImpl implements LanguageService {
  final SharedPrefService _sharedPrefService;
  LanguageServiceImpl({required SharedPrefService sharedPrefService})
    : _sharedPrefService = sharedPrefService;

  @override
  Future<String?> getLanguage() async {
    final result = await _sharedPrefService.getSharedPref(
      AppSharedPrefKey.language,
    );
    return result;
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    await _sharedPrefService.setSharedPref(
      AppSharedPrefKey.language,
      languageCode,
    );
  }

  factory LanguageServiceImpl.create() {
    return LanguageServiceImpl(
      sharedPrefService: SharedPrefServiceImpl.create(),
    );
  }
}
