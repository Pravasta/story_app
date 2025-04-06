enum GlobalState {
  initial,
  loading,
  changedLoading,
  loaded,
  failed,
  dialogLoading,
  hideDialogLoading,
  successSubmit,
  loadMore,
}

extension GlobalStateExtension on GlobalState {
  bool get isInitial => this == GlobalState.initial;
  bool get isLoading => this == GlobalState.loading;
  bool get isChangedLoading => this == GlobalState.changedLoading;
  bool get isLoaded => this == GlobalState.loaded;
  bool get isFailed => this == GlobalState.failed;
  bool get isDialogLoading => this == GlobalState.dialogLoading;
  bool get isHideDialogLoading => this == GlobalState.hideDialogLoading;
  bool get isSuccessSubmit => this == GlobalState.successSubmit;
  bool get isLoadMore => this == GlobalState.loadMore;
}
