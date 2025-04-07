import '../services/l10n/language_service.dart';

abstract class LanguageRepositories {
  Future<void> setLanguage(String languageCode);
  Future<String?> getLanguage();
}

class LanguageRepositoriesImpl implements LanguageRepositories {
  final LanguageService _languageService;
  LanguageRepositoriesImpl({required LanguageService languageService})
    : _languageService = languageService;

  @override
  Future<String?> getLanguage() async {
    final result = await _languageService.getLanguage();
    return result;
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    await _languageService.setLanguage(languageCode);
  }

  factory LanguageRepositoriesImpl.create() {
    return LanguageRepositoriesImpl(
      languageService: LanguageServiceImpl.create(),
    );
  }
}
