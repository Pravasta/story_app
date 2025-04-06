import '../../../core/services/auth/auth_local_service.dart';

abstract class SplashRepository {
  Future<bool> isLogin();
}

class SplashRepositoryImpl implements SplashRepository {
  final AuthLocalService _authLocalService;

  SplashRepositoryImpl({required AuthLocalService authLocalService})
    : _authLocalService = authLocalService;

  @override
  Future<bool> isLogin() async {
    final result = await _authLocalService.getAuthData();

    return result != null;
  }

  factory SplashRepositoryImpl.create() {
    return SplashRepositoryImpl(
      authLocalService: AuthLocalServiceImpl.create(),
    );
  }
}
