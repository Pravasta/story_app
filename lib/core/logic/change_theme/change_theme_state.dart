part of 'change_theme_cubit.dart';

enum ChangeThemeStatus { initial, loading, success, failure }

extension ChangeThemeStatusX on ChangeThemeStatus {
  bool get isInitial => this == ChangeThemeStatus.initial;
  bool get isLoading => this == ChangeThemeStatus.loading;
  bool get isSuccess => this == ChangeThemeStatus.success;
  bool get isFailure => this == ChangeThemeStatus.failure;
}

class ChangeThemeState {
  const ChangeThemeState({
    this.status = ChangeThemeStatus.initial,
    this.isDarkMode = false,
    this.error,
  });

  final ChangeThemeStatus status;
  final bool isDarkMode;
  final String? error;

  ChangeThemeState copyWith({
    ChangeThemeStatus? status,
    bool? isDarkMode,
    String? error,
  }) {
    return ChangeThemeState(
      status: status ?? this.status,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      error: error ?? this.error,
    );
  }
}
