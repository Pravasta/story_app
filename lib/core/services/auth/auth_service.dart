import 'package:story_app/core/endpoint/endpoint.dart';
import 'package:story_app/core/exception/app_exception.dart';
import 'package:story_app/core/model/request/login_request_model.dart';
import 'package:story_app/core/model/request/register_request_model.dart';
import 'package:story_app/core/model/response/login_response_model.dart';
import 'package:story_app/core/model/response/register_response_model.dart';
import 'package:story_app/core/network/http_client.dart';
import 'package:story_app/core/services/auth/auth_local_service.dart';

abstract class AuthService {
  Future<RegisterResponseModel> register(RegisterRequestModel data);
  Future<LoginResponseModel> login(LoginRequestModel data);
  Future<LoginResult> getDataUser();
  Future<void> setAuthData(LoginResult loginResult);
}

class AuthServiceImpl implements AuthService {
  final Endpoint _endpoint;
  final CoinsleekHttpClient _httpClient;
  final AuthLocalService _authLocalService;

  AuthServiceImpl({
    required Endpoint endpoint,
    required CoinsleekHttpClient httpClient,
    required AuthLocalService authLocalService,
  }) : _endpoint = endpoint,
       _httpClient = httpClient,
       _authLocalService = authLocalService;

  @override
  Future<LoginResponseModel> login(LoginRequestModel data) async {
    final url = _endpoint.login();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = data.toJson();

    try {
      final response = await _httpClient.post(url, headers, body);
      return LoginResponseModel.fromJson(response.body);
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString()).message;
    }
  }

  @override
  Future<RegisterResponseModel> register(RegisterRequestModel data) async {
    final url = _endpoint.register();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = data.toJson();

    try {
      final response = await _httpClient.post(url, headers, body);
      return RegisterResponseModel.fromJson(response.body);
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString()).message;
    }
  }

  @override
  Future<LoginResult> getDataUser() async {
    try {
      final authData = await _authLocalService.getAuthData();
      if (authData != null) {
        return authData;
      } else {
        throw AppException('No user data found').message;
      }
    } catch (e) {
      throw AppException(e.toString()).message;
    }
  }

  @override
  Future<void> setAuthData(LoginResult loginResult) async {
    try {
      await _authLocalService.setAuthData(loginResult);
    } catch (e) {
      throw AppException(e.toString()).message;
    }
  }

  factory AuthServiceImpl.create() {
    return AuthServiceImpl(
      endpoint: Endpoint.baseUrlApi(),
      httpClient: CoinsleekHttpClient.create(),
      authLocalService: AuthLocalServiceImpl.create(),
    );
  }
}
