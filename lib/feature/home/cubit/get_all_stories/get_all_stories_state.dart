part of 'get_all_stories_cubit.dart';

enum GetAllStoriesStatus { loading, success, error, initial }

extension GetAllStoriesStatusExtension on GetAllStoriesStatus {
  bool get isLoading => this == GetAllStoriesStatus.loading;
  bool get isSuccess => this == GetAllStoriesStatus.success;
  bool get isError => this == GetAllStoriesStatus.error;
  bool get isInitial => this == GetAllStoriesStatus.initial;
}

class GetAllStoriesState {
  final String message;
  final List<ListStory> listStory;
  final GetAllStoriesStatus status;

  const GetAllStoriesState({
    this.message = '',
    this.listStory = const [],
    this.status = GetAllStoriesStatus.initial,
  });

  GetAllStoriesState copyWith({
    String? message,
    List<ListStory>? listStory,
    GetAllStoriesStatus? status,
  }) {
    return GetAllStoriesState(
      message: message ?? this.message,
      listStory: listStory ?? this.listStory,
      status: status ?? this.status,
    );
  }
}
