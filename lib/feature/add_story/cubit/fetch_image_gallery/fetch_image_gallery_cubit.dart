import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/add_story/repository/add_story_repository.dart';

part 'fetch_image_gallery_state.dart';

class FetchImageGalleryCubit extends Cubit<FetchImageGalleryState> {
  FetchImageGalleryCubit(this._addStoryRepository)
    : super(FetchImageGalleryState());

  final AddStoryRepository _addStoryRepository;

  void fetchImageGallery() async {
    try {
      emit(state.copyWith(status: FetchImageGalleryStatus.loading));
      final assets = await _addStoryRepository.getAllImages();

      emit(
        state.copyWith(status: FetchImageGalleryStatus.success, assets: assets),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FetchImageGalleryStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  void selectImage(XFile? image) {
    emit(state.copyWith(status: FetchImageGalleryStatus.loading));
    try {
      emit(
        state.copyWith(
          status: FetchImageGalleryStatus.success,
          selectedImage: image,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FetchImageGalleryStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }
}
