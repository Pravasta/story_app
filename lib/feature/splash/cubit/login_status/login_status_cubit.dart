import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/splash/repository/splash_repository.dart';

part 'login_status_state.dart';

class LoginStatusCubit extends Cubit<LoginStatusState> {
  LoginStatusCubit(this._repository) : super(LoginStatusState());

  final SplashRepository _repository;

  void checkLoginStatus() async {
    emit(state.copyWith(status: LoginStatus.loading));
    final isLoggedIn = await _repository.isLogin();

    await Future.delayed(const Duration(seconds: 3));

    try {
      if (isLoggedIn) {
        emit(
          state.copyWith(
            status: LoginStatus.authenticated,
            message: 'User is logged in',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: LoginStatus.unauthenticated,
            message: 'User is not logged in',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          message: 'Error checking login status: $e',
        ),
      );
    }
  }
}
