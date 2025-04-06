import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:story_app/feature/add_story/repository/camera_repository.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit(this._cameraRepository) : super(CameraState());

  final CameraRepository _cameraRepository;

  void initCamera() async {
    emit(state.copyWith(status: CameraStatus.loading));
    try {
      final cameras = await _cameraRepository.getAvailableCameras();
      if (cameras.isNotEmpty) {
        final cameraController = await _cameraRepository.initializeCamera(
          cameras.first,
        );
        emit(
          state.copyWith(
            status: CameraStatus.success,
            cameraController: cameraController,
            isInitialized: cameraController.value.isInitialized,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: CameraStatus.error,
            errorMessage: 'No cameras available',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: CameraStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void switchCamera() async {
    try {
      final cameras = await _cameraRepository.getAvailableCameras();
      final currentIndex = cameras.indexOf(state.cameraController!.description);
      final nextIndex = (currentIndex + 1) % cameras.length;
      final nextCamera = cameras[nextIndex];
      final cameraController = await _cameraRepository.initializeCamera(
        nextCamera,
      );
      emit(
        state.copyWith(
          status: CameraStatus.success,
          cameraController: cameraController,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: CameraStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void takePicture() async {
    emit(state.copyWith(status: CameraStatus.takePictureLoading));
    try {
      final result = await _cameraRepository.takePicture(
        state.cameraController!,
      );
      emit(
        state.copyWith(
          status: CameraStatus.takePicture,
          cameraController: state.cameraController,
          image: result,
          imagePath: result?.path,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: CameraStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void disposeCamera() {
    _cameraRepository.disposeCamera(state.cameraController!);
    emit(state.copyWith(status: CameraStatus.initial));
  }
}
