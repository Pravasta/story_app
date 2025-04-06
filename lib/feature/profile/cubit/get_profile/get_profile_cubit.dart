import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/core/model/response/login_response_model.dart';
import 'package:story_app/feature/profile/repository/profile_repository.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit(this._repository) : super(GetProfileState());

  final ProfileRepository _repository;

  void getProfile() async {
    emit(state.copyWith(status: GetProfileStatus.loading));

    try {
      final result = await _repository.getProfile();
      emit(
        state.copyWith(status: GetProfileStatus.success, loginResult: result),
      );
    } catch (e) {
      emit(
        state.copyWith(status: GetProfileStatus.error, message: e.toString()),
      );
    }
  }
}
