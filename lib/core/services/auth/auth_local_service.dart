import 'package:story_app/core/local_storage/shared_pref_key.dart';
import 'package:story_app/core/local_storage/shared_pref_service.dart';
import 'package:story_app/core/model/response/login_response_model.dart';

abstract class AuthLocalService {
  Future<void> setAuthData(LoginResult loginResult);
  Future<LoginResult?> getAuthData();
  Future<void> removeAuthData();
  Future<void> clearAuthData();
}

class AuthLocalServiceImpl implements AuthLocalService {
  final SharedPrefService _sharedPrefService;

  AuthLocalServiceImpl({required SharedPrefService sharedPrefService})
    : _sharedPrefService = sharedPrefService;

  @override
  Future<void> clearAuthData() async {
    await _sharedPrefService.clearSharedPref();
  }

  @override
  Future<LoginResult?> getAuthData() async {
    final result = await _sharedPrefService.getSharedPref(
      AppSharedPrefKey.isLogin,
    );
    if (result != null) {
      return LoginResult.fromJson(result);
    }
    return null;
  }

  @override
  Future<void> removeAuthData() {
    return _sharedPrefService.removeSharedPref(AppSharedPrefKey.isLogin);
  }

  @override
  Future<void> setAuthData(LoginResult loginResult) async {
    await _sharedPrefService.setSharedPref(
      AppSharedPrefKey.isLogin,
      loginResult.toJson(),
    );
  }

  factory AuthLocalServiceImpl.create() {
    return AuthLocalServiceImpl(
      sharedPrefService: SharedPrefServiceImpl.create(),
    );
  }
}
