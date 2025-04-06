import 'package:photo_manager/photo_manager.dart';

abstract class GalleryService {
  Future<List<AssetEntity>> getAllAssets();
}

class GalleryServiceImpl implements GalleryService {
  @override
  Future<List<AssetEntity>> getAllAssets() async {
    try {
      final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );
      if (albums.isNotEmpty) {
        List<AssetEntity> media = await albums.first.getAssetListPaged(
          page: 0,
          size: 100,
        );
        return media;
      } else {
        return [];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
