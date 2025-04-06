import 'package:story_app/core/model/response/login_response_model.dart';
import 'package:story_app/core/services/auth/auth_local_service.dart';

abstract class ProfileRepository {
  Future<LoginResult> getProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final AuthLocalService _authLocalService;

  ProfileRepositoryImpl({required AuthLocalService authLocalService})
    : _authLocalService = authLocalService;

  @override
  Future<LoginResult> getProfile() async {
    try {
      final result = await _authLocalService.getAuthData();
      if (result != null) {
        return result;
      } else {
        throw Exception('No profile data found');
      }
    } catch (e) {
      throw Exception('Failed to fetch profile data: $e');
    }
  }

  factory ProfileRepositoryImpl.create() {
    return ProfileRepositoryImpl(
      authLocalService: AuthLocalServiceImpl.create(),
    );
  }
}
