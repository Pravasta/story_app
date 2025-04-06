import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/detail_story/repository/detail_repository.dart';

import '../../../core/model/response/get_detail_story_response_model.dart';

part 'get_detail_story_state.dart';

class GetDetailStoryCubit extends Cubit<GetDetailStoryState> {
  GetDetailStoryCubit(this._repository) : super(GetDetailStoryState());

  final DetailRepository _repository;

  void getDetailStory(String id) async {
    emit(state.copyWith(status: GetDetailStoryStatus.loading));

    try {
      final result = await _repository.getDetailStory(id);
      emit(state.copyWith(status: GetDetailStoryStatus.success, story: result));
    } catch (e) {
      emit(
        state.copyWith(
          status: GetDetailStoryStatus.error,
          message: e.toString(),
        ),
      );
    }
  }
}
