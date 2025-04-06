import 'package:camera/camera.dart';

abstract class CameraService {
  Future<List<CameraDescription>> getAvailableCameras();
  Future<CameraController> initializeCamera(CameraDescription camera);
  Future<XFile?> takePicture(CameraController cameraController);
  void disposeCamera(CameraController cameraController);
}

class CameraServiceImpl implements CameraService {
  @override
  Future<List<CameraDescription>> getAvailableCameras() async {
    try {
      final cameras = await availableCameras();
      print('Available cameras: $cameras');
      return cameras;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<CameraController> initializeCamera(CameraDescription camera) async {
    try {
      final cameraController = CameraController(camera, ResolutionPreset.high);
      await cameraController.initialize();
      print('Camera initialized: ${cameraController.value}');
      return cameraController;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<XFile?> takePicture(CameraController cameraController) async {
    try {
      if (!cameraController.value.isInitialized) {
        throw 'Camera is not initialized';
      }
      if (cameraController.value.isTakingPicture) {
        return null;
      }
      final image = await cameraController.takePicture();
      return image;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void disposeCamera(CameraController cameraController) {
    cameraController.dispose();
  }
}
