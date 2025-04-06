import 'package:story_app/core/model/response/get_all_stories_response_model.dart';
import 'package:story_app/core/services/stories/stories_service.dart';

abstract class HomeRepository {
  Future<List<ListStory>> getAllStories(int page, int size, int location);
}

class HomeRepositoryImpl implements HomeRepository {
  final StoriesService _storiesService;

  HomeRepositoryImpl({required StoriesService storiesService})
    : _storiesService = storiesService;

  @override
  Future<List<ListStory>> getAllStories(
    int page,
    int size,
    int location,
  ) async {
    try {
      final result = await _storiesService.getAllStories(page, size, location);
      return result.listStory ?? [];
    } catch (e) {
      throw e.toString();
    }
  }

  factory HomeRepositoryImpl.create() {
    return HomeRepositoryImpl(storiesService: StoriesServiceImpl.create());
  }
}
