import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/core/repositories/app_permissions_repositories.dart';

part 'app_permissions_state.dart';

class AppPermissionsCubit extends Cubit<AppPermissionsState> {
  AppPermissionsCubit(this._appPermissionsRepositories)
    : super(AppPermissionsState());

  final AppPermissionsRepositories _appPermissionsRepositories;

  void checkGalleryPermission() async {
    emit(state.copyWith(status: AppPermissionsStatus.loading));
    try {
      final permission = await _appPermissionsRepositories.galleryPermission();
      emit(
        state.copyWith(
          status:
              permission
                  ? AppPermissionsStatus.granted
                  : AppPermissionsStatus.denied,
          message:
              permission
                  ? ''
                  : 'Permission to access gallery is denied. Please allow access in settings.',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AppPermissionsStatus.denied,
          message: e.toString(),
        ),
      );
    }
  }

  void checkCameraPermission() async {
    emit(state.copyWith(status: AppPermissionsStatus.loading));
    try {
      final permission = await _appPermissionsRepositories.cameraPermission();
      emit(
        state.copyWith(
          status:
              permission
                  ? AppPermissionsStatus.granted
                  : AppPermissionsStatus.denied,
          message:
              permission
                  ? ''
                  : 'Permission to access camera is denied. Please allow access in settings.',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AppPermissionsStatus.denied,
          message: e.toString(),
        ),
      );
    }
  }
}
