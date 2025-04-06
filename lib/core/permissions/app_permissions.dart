import 'package:permission_handler/permission_handler.dart';

abstract class AppPermissions {
  Future<bool> galleryPermission();
  Future<bool> cameraPermission();
}

class AppPermissionsImpl implements AppPermissions {
  @override
  Future<bool> galleryPermission() async {
    final status = await Permission.photos.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      final result = await Permission.photos.request();
      if (result.isGranted) {
        return true;
      } else {
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      await Permission.photos.request();
      return false;
    } else {
      return false;
    }
  }

  @override
  Future<bool> cameraPermission() async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        return true;
      } else {
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      await Permission.camera.request();
      return false;
    } else {
      return false;
    }
  }
}
