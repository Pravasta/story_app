import 'package:camera/camera.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:story_app/core/model/request/add_new_story_request_model.dart';
import 'package:story_app/core/services/gallery/gallery_service.dart';
import 'package:story_app/core/services/stories/stories_service.dart';

abstract class AddStoryRepository {
  Future<List<XFile?>> getAllImages();
  Future<String> addNewStory(AddNewStoryRequestModel data);
}

class AddStoryRepositoryImpl implements AddStoryRepository {
  final GalleryService _galleryService;
  final StoriesService _storiesService;

  AddStoryRepositoryImpl({
    required GalleryService galleryService,
    required StoriesService storiesService,
  }) : _galleryService = galleryService,
       _storiesService = storiesService;

  @override
  Future<List<XFile?>> getAllImages() async {
    try {
      final List<AssetEntity> assets = await _galleryService.getAllAssets();
      final List<XFile?> files = [];

      for (var asset in assets) {
        final file = await asset.file;
        if (file != null) {
          files.add(XFile(file.path));
        }
      }

      return files;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<String> addNewStory(AddNewStoryRequestModel data) async {
    try {
      final result = await _storiesService.addNewStory(data);
      return result.message ?? '';
    } catch (e) {
      throw e.toString();
    }
  }

  factory AddStoryRepositoryImpl.create() {
    return AddStoryRepositoryImpl(
      galleryService: GalleryServiceImpl(),
      storiesService: StoriesServiceImpl.create(),
    );
  }
}
