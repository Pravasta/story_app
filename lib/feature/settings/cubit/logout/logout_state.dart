part of 'logout_cubit.dart';

class LogoutState {
  final String message;
  final GlobalState state;

  const LogoutState({this.message = '', this.state = GlobalState.initial});

  LogoutState copyWith({String? message, GlobalState? state}) {
    return LogoutState(
      message: message ?? this.message,
      state: state ?? this.state,
    );
  }
}
