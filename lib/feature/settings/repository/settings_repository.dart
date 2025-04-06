import 'package:story_app/core/services/auth/auth_local_service.dart';

abstract class SettingsRepository {
  Future<String> logout();
}

class SettingsRepositoryImpl implements SettingsRepository {
  final AuthLocalService _authLocalService;

  SettingsRepositoryImpl({required AuthLocalService authLocalService})
    : _authLocalService = authLocalService;

  @override
  Future<String> logout() async {
    try {
      await _authLocalService.removeAuthData();
      return "Logout successful";
    } catch (_) {
      throw 'Logout Failed';
    }
  }

  factory SettingsRepositoryImpl.create() {
    return SettingsRepositoryImpl(
      authLocalService: AuthLocalServiceImpl.create(),
    );
  }
}
