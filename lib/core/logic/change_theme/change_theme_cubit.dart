import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/core/repositories/theme_repositories.dart';

part 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  ChangeThemeCubit(this._repositories) : super(ChangeThemeState());

  final ThemeRepositories _repositories;

  void setTheme(bool isDarkMode) async {
    emit(state.copyWith(status: ChangeThemeStatus.loading));
    try {
      await _repositories.setTheme(isDarkMode);
      emit(
        state.copyWith(
          status: ChangeThemeStatus.success,
          isDarkMode: isDarkMode,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ChangeThemeStatus.failure, error: e.toString()),
      );
    }
  }

  void getTheme() async {
    emit(state.copyWith(status: ChangeThemeStatus.loading));
    try {
      final result = await _repositories.getTheme();
      emit(
        state.copyWith(status: ChangeThemeStatus.success, isDarkMode: result),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ChangeThemeStatus.failure, error: e.toString()),
      );
    }
  }
}
