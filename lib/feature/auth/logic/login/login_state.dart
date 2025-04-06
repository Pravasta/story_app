part of 'login_cubit.dart';

class LoginState {
  final String message;
  final LoginResult? loginResult;
  final GlobalState globalState;

  const LoginState({
    this.message = '',
    this.loginResult,
    this.globalState = GlobalState.initial,
  });

  LoginState copyWith({
    String? message,
    LoginResult? loginResult,
    GlobalState? globalState,
  }) {
    return LoginState(
      message: message ?? this.message,
      loginResult: loginResult ?? this.loginResult,
      globalState: globalState ?? this.globalState,
    );
  }
}
