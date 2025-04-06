part of 'get_detail_story_cubit.dart';

enum GetDetailStoryStatus { loading, success, error, initial }

extension GetDetailStoryStatusExtension on GetDetailStoryStatus {
  bool get isLoading => this == GetDetailStoryStatus.loading;
  bool get isSuccess => this == GetDetailStoryStatus.success;
  bool get isError => this == GetDetailStoryStatus.error;
  bool get isInitial => this == GetDetailStoryStatus.initial;
}

class GetDetailStoryState {
  final String message;
  final Story? story;
  final GetDetailStoryStatus status;

  const GetDetailStoryState({
    this.message = '',
    this.story,
    this.status = GetDetailStoryStatus.initial,
  });

  GetDetailStoryState copyWith({
    String? message,
    Story? story,
    GetDetailStoryStatus? status,
  }) {
    return GetDetailStoryState(
      message: message ?? this.message,
      story: story ?? this.story,
      status: status ?? this.status,
    );
  }
}
