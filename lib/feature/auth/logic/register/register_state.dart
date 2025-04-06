part of 'register_cubit.dart';

class RegisterState {
  final String message;
  final GlobalState globalState;

  const RegisterState({
    this.message = '',
    this.globalState = GlobalState.initial,
  });

  RegisterState copyWith({String? message, GlobalState? globalState}) {
    return RegisterState(
      message: message ?? this.message,
      globalState: globalState ?? this.globalState,
    );
  }
}
