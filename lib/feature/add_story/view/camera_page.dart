import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/add_story/cubit/camera/camera_cubit.dart';
import 'package:story_app/feature/add_story/repository/camera_repository.dart';
import 'package:story_app/feature/add_story/view/camera_view.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraCubit(CameraRepositoryImpl.create()),
      child: CameraView(),
    );
  }
}
