import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/core/repositories/language_repositories.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(this._repositories) : super(LanguageState());

  final LanguageRepositories _repositories;

  Future<void> setLanguage(String languageCode) async {
    emit(state.copyWith(status: LanguageStatus.loading));
    try {
      await _repositories.setLanguage(languageCode);
      emit(
        state.copyWith(
          status: LanguageStatus.success,
          languageCode: languageCode,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: LanguageStatus.failure, error: e.toString()));
    }
  }

  Future<void> getLanguage() async {
    emit(state.copyWith(status: LanguageStatus.loading));
    try {
      final result = await _repositories.getLanguage();
      emit(
        state.copyWith(
          status: LanguageStatus.success,
          languageCode: result ?? 'en',
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: LanguageStatus.failure, error: e.toString()));
    }
  }
}
