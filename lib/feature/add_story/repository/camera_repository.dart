import 'package:camera/camera.dart';
import 'package:story_app/core/services/camera/camera_service.dart';

abstract class CameraRepository {
  Future<List<CameraDescription>> getAvailableCameras();
  Future<CameraController> initializeCamera(CameraDescription camera);
  Future<XFile?> takePicture(CameraController cameraController);
  void disposeCamera(CameraController cameraController) {
    cameraController.dispose();
  }
}

class CameraRepositoryImpl implements CameraRepository {
  final CameraService _cameraService;

  CameraRepositoryImpl({required CameraService cameraService})
    : _cameraService = cameraService;

  @override
  Future<List<CameraDescription>> getAvailableCameras() async {
    try {
      final cameras = await _cameraService.getAvailableCameras();

      return cameras;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<CameraController> initializeCamera(CameraDescription camera) async {
    try {
      final cameraController = await _cameraService.initializeCamera(camera);

      return cameraController;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<XFile?> takePicture(CameraController cameraController) async {
    try {
      final image = await _cameraService.takePicture(cameraController);
      return image;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void disposeCamera(CameraController cameraController) {
    _cameraService.disposeCamera(cameraController);
  }

  factory CameraRepositoryImpl.create() {
    return CameraRepositoryImpl(cameraService: CameraServiceImpl());
  }
}
