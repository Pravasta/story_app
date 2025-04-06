import 'package:story_app/core/model/response/get_detail_story_response_model.dart';
import 'package:story_app/core/services/stories/stories_service.dart';

abstract class DetailRepository {
  Future<Story> getDetailStory(String id);
}

class DetailRepositoryImpl implements DetailRepository {
  final StoriesService _storiesService;

  DetailRepositoryImpl({required StoriesService storiesService})
    : _storiesService = storiesService;

  @override
  Future<Story> getDetailStory(String id) async {
    try {
      final result = await _storiesService.getDetailStory(id);
      return result.story ?? Story();
    } catch (e) {
      rethrow;
    }
  }

  factory DetailRepositoryImpl.create() {
    return DetailRepositoryImpl(storiesService: StoriesServiceImpl.create());
  }
}
