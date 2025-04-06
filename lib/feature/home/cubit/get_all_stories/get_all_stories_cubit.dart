import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/core/model/response/get_all_stories_response_model.dart';
import 'package:story_app/feature/home/repository/home_repository.dart';

part 'get_all_stories_state.dart';

class GetAllStoriesCubit extends Cubit<GetAllStoriesState> {
  GetAllStoriesCubit(this._homeRepository) : super(GetAllStoriesState());

  final HomeRepository _homeRepository;

  void getAllStories() async {
    emit(state.copyWith(status: GetAllStoriesStatus.loading));

    try {
      final result = await _homeRepository.getAllStories(1, 10, 0);
      emit(
        state.copyWith(status: GetAllStoriesStatus.success, listStory: result),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GetAllStoriesStatus.error,
          message: e.toString(),
        ),
      );
    }
  }
}
