import 'package:story_app/core/model/request/login_request_model.dart';
import 'package:story_app/core/model/request/register_request_model.dart';
import 'package:story_app/core/model/response/login_response_model.dart';
import 'package:story_app/core/services/auth/auth_service.dart';

abstract class AuthRepository {
  Future<String> register(RegisterRequestModel data);
  Future<LoginResult> login(LoginRequestModel data);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({required AuthService authService})
    : _authService = authService;

  @override
  Future<String> register(RegisterRequestModel data) async {
    try {
      final response = await _authService.register(data);
      return response.message;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginResult> login(LoginRequestModel data) async {
    try {
      final response = await _authService.login(data);
      await _authService.setAuthData(response.loginResult);
      return response.loginResult;
    } catch (e) {
      rethrow;
    }
  }

  factory AuthRepositoryImpl.create() {
    return AuthRepositoryImpl(authService: AuthServiceImpl.create());
  }
}
