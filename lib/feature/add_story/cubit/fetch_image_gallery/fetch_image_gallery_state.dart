part of 'fetch_image_gallery_cubit.dart';

enum FetchImageGalleryStatus { initial, loading, success, failure }

extension FetchImageGalleryStatusX on FetchImageGalleryStatus {
  bool get isInitial => this == FetchImageGalleryStatus.initial;
  bool get isLoading => this == FetchImageGalleryStatus.loading;
  bool get isSuccess => this == FetchImageGalleryStatus.success;
  bool get isFailure => this == FetchImageGalleryStatus.failure;
}

class FetchImageGalleryState {
  final String message;
  final List<XFile?> assets;
  final FetchImageGalleryStatus status;
  final XFile? selectedImage;

  const FetchImageGalleryState({
    this.message = '',
    this.assets = const [],
    this.status = FetchImageGalleryStatus.initial,
    this.selectedImage,
  });

  FetchImageGalleryState copyWith({
    String? message,
    List<XFile?>? assets,
    FetchImageGalleryStatus? status,
    XFile? selectedImage,
  }) {
    return FetchImageGalleryState(
      message: message ?? this.message,
      assets: assets ?? this.assets,
      status: status ?? this.status,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}
