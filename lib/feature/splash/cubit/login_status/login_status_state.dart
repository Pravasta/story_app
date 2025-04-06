part of 'login_status_cubit.dart';

enum LoginStatus { loading, authenticated, unauthenticated, initial, error }

class LoginStatusState {
  final String message;
  final LoginStatus status;

  const LoginStatusState({
    this.message = '',
    this.status = LoginStatus.initial,
  });

  LoginStatusState copyWith({String? message, LoginStatus? status}) {
    return LoginStatusState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
