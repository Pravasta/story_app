import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/core/model/request/register_request_model.dart';

import 'package:story_app/core/utils/global_state.dart';
import 'package:story_app/feature/auth/repository/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authRepository) : super(RegisterState());

  final AuthRepository _authRepository;

  void register(RegisterRequestModel data) async {
    emit(state.copyWith(globalState: GlobalState.loading));

    try {
      final message = await _authRepository.register(data);
      emit(
        state.copyWith(
          globalState: GlobalState.successSubmit,
          message: message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(globalState: GlobalState.failed, message: e.toString()),
      );
    }
  }
}
