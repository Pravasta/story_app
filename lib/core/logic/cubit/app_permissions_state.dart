part of 'app_permissions_cubit.dart';

enum AppPermissionsStatus { denied, granted, initial, loading }

extension AppPermissionsStatusX on AppPermissionsStatus {
  bool get isGranted => this == AppPermissionsStatus.granted;
  bool get isDenied => this == AppPermissionsStatus.denied;
  bool get isInitial => this == AppPermissionsStatus.initial;
  bool get isLoading => this == AppPermissionsStatus.loading;
}

class AppPermissionsState {
  const AppPermissionsState({
    this.status = AppPermissionsStatus.initial,
    this.message = '',
  });

  final AppPermissionsStatus status;
  final String message;

  AppPermissionsState copyWith({
    AppPermissionsStatus? status,
    String? message,
  }) {
    return AppPermissionsState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
