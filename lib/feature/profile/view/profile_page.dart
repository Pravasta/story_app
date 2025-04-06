import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/profile/cubit/get_profile/get_profile_cubit.dart';
import 'package:story_app/feature/profile/repository/profile_repository.dart';

import 'profile_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => GetProfileCubit(ProfileRepositoryImpl.create())..getProfile(),
      child: const ProfileView(),
    );
  }
}
