part of 'get_profile_cubit.dart';

enum GetProfileStatus { loading, success, error, initial }

extension GetProfileStatusExtension on GetProfileStatus {
  bool get isLoading => this == GetProfileStatus.loading;
  bool get isSuccess => this == GetProfileStatus.success;
  bool get isError => this == GetProfileStatus.error;
  bool get isInitial => this == GetProfileStatus.initial;
}

class GetProfileState {
  final String message;
  final GetProfileStatus status;
  final LoginResult? loginResult;

  const GetProfileState({
    this.message = '',
    this.status = GetProfileStatus.initial,
    this.loginResult,
  });

  GetProfileState copyWith({
    String? message,
    GetProfileStatus? status,
    LoginResult? loginResult,
  }) {
    return GetProfileState(
      message: message ?? this.message,
      status: status ?? this.status,
      loginResult: loginResult ?? this.loginResult,
    );
  }
}
