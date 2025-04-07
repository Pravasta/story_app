part of 'language_cubit.dart';

enum LanguageStatus { initial, loading, success, failure }

extension LanguageStatusX on LanguageStatus {
  bool get isInitial => this == LanguageStatus.initial;
  bool get isLoading => this == LanguageStatus.loading;
  bool get isSuccess => this == LanguageStatus.success;
  bool get isFailure => this == LanguageStatus.failure;
}

class LanguageState {
  final String languageCode;
  final String error;
  final LanguageStatus status;

  const LanguageState({
    this.languageCode = 'en',
    this.error = '',
    this.status = LanguageStatus.initial,
  });

  LanguageState copyWith({
    String? languageCode,
    String? error,
    LanguageStatus? status,
  }) {
    return LanguageState(
      languageCode: languageCode ?? this.languageCode,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
