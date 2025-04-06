part of 'camera_cubit.dart';

enum CameraStatus {
  initial,
  loading,
  error,
  success,
  takePicture,
  takePictureLoading,
}

extension CameraStatusX on CameraStatus {
  bool get isInitial => this == CameraStatus.initial;
  bool get isLoading => this == CameraStatus.loading;
  bool get isError => this == CameraStatus.error;
  bool get isSuccess => this == CameraStatus.success;
  bool get isTakePicture => this == CameraStatus.takePicture;
  bool get isTakePictureLoading => this == CameraStatus.takePictureLoading;
}

class CameraState {
  final bool isInitialized;
  final CameraController? cameraController;
  final String errorMessage;
  final CameraStatus status;
  final XFile? image;
  final String? imagePath;

  const CameraState({
    this.isInitialized = false,
    this.cameraController,
    this.errorMessage = '',
    this.status = CameraStatus.initial,
    this.image,
    this.imagePath,
  });

  CameraState copyWith({
    bool? isInitialized,
    CameraController? cameraController,
    String? errorMessage,
    CameraStatus? status,
    XFile? image,
    String? imagePath,
  }) {
    return CameraState(
      isInitialized: isInitialized ?? this.isInitialized,
      cameraController: cameraController ?? this.cameraController,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      image: image ?? this.image,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
