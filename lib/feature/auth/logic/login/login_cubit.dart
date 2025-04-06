import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/core/model/request/login_request_model.dart';

import 'package:story_app/core/model/response/login_response_model.dart';
import 'package:story_app/core/utils/global_state.dart';
import 'package:story_app/feature/auth/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(LoginState());

  final AuthRepository _authRepository;

  void login(LoginRequestModel data) async {
    emit(state.copyWith(globalState: GlobalState.loading));

    try {
      final loginResult = await _authRepository.login(data);
      emit(
        state.copyWith(
          globalState: GlobalState.successSubmit,
          loginResult: loginResult,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(globalState: GlobalState.failed, message: e.toString()),
      );
    }
  }
}
