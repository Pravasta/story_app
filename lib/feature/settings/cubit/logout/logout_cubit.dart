import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:story_app/core/utils/global_state.dart';
import 'package:story_app/feature/settings/repository/settings_repository.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._settingsRepository) : super(LogoutState());

  final SettingsRepository _settingsRepository;

  void logout() async {
    emit(state.copyWith(state: GlobalState.loading));

    await Future.delayed(const Duration(seconds: 3));

    try {
      final message = await _settingsRepository.logout();
      emit(state.copyWith(message: message, state: GlobalState.successSubmit));
    } catch (e) {
      emit(state.copyWith(message: e.toString(), state: GlobalState.failed));
    }
  }
}
