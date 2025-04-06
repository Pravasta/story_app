import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/core/model/request/add_new_story_request_model.dart';
import 'package:story_app/core/utils/global_state.dart';
import 'package:story_app/feature/add_story/repository/add_story_repository.dart';

part 'add_new_story_state.dart';

class AddNewStoryCubit extends Cubit<AddNewStoryState> {
  AddNewStoryCubit(this._addStoryRepository) : super(AddNewStoryState());

  final AddStoryRepository _addStoryRepository;

  void addNewStory(AddNewStoryRequestModel data) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final result = await _addStoryRepository.addNewStory(data);
      emit(state.copyWith(status: GlobalState.successSubmit, message: result));
    } catch (e) {
      emit(state.copyWith(status: GlobalState.failed, message: e.toString()));
    }
  }
}
