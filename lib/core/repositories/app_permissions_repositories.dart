import 'package:story_app/core/permissions/app_permissions.dart';

abstract class AppPermissionsRepositories {
  Future<bool> galleryPermission();
  Future<bool> cameraPermission();
}

class AppPermissionsRepositoriesImpl implements AppPermissionsRepositories {
  final AppPermissions _appPermissions;

  AppPermissionsRepositoriesImpl({required AppPermissions appPermissions})
    : _appPermissions = appPermissions;

  @override
  Future<bool> cameraPermission() async {
    try {
      final status = await _appPermissions.cameraPermission();
      return status;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<bool> galleryPermission() async {
    try {
      final status = await _appPermissions.galleryPermission();
      return status;
    } catch (e) {
      throw e.toString();
    }
  }

  factory AppPermissionsRepositoriesImpl.create() {
    return AppPermissionsRepositoriesImpl(appPermissions: AppPermissionsImpl());
  }
}
