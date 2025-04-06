part of 'add_new_story_cubit.dart';

class AddNewStoryState {
  final String message;
  final GlobalState status;

  const AddNewStoryState({
    this.message = '',
    this.status = GlobalState.initial,
  });

  AddNewStoryState copyWith({String? message, GlobalState? status}) {
    return AddNewStoryState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
