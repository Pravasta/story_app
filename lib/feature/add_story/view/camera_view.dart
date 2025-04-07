import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/components/app_loading.dart';
import 'package:story_app/core/components/app_top_snackbar.dart';
import 'package:story_app/core/extensions/build_context_ext.dart';
import 'package:story_app/core/model/request/preview_story_request_model.dart';
import 'package:story_app/core/routes/routes_name.dart';
import 'package:story_app/feature/add_story/cubit/camera/camera_cubit.dart';
import 'package:story_app/main.dart';

import '../../../core/common/common.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  late CameraCubit _cameraCubit;

  @override
  initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _cameraCubit = context.read<CameraCubit>();
    _cameraCubit.initCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraCubit.state.cameraController == null ||
        !_cameraCubit.state.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _cameraCubit.state.cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _cameraCubit.initCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_cameraCubit.state.cameraController != null) {
      _cameraCubit.state.cameraController?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget featureHeaderCameraSection() {
      return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              IconButton(
                onPressed: () {
                  AppTopSnackBar(context).showInfo(
                    AppLocalizations.of(context)!.feature_not_available,
                  );
                },
                icon: Icon(
                  Icons.flash_off_outlined,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget cameraViewSection() {
      return BlocBuilder<CameraCubit, CameraState>(
        builder: (context, state) {
          if (state.status.isLoading ||
              !state.isInitialized ||
              state.cameraController == null) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.status.isError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: appTextTheme(context).titleLarge,
              ),
            );
          }

          return Container(
            width: context.deviceWidth,
            height: context.deviceHeight * 0.75,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: CameraPreview(state.cameraController!),
          );
        },
      );
    }

    Widget buttonCaptureSection() {
      return Positioned(
        right: 0,
        left: 0,
        top: context.deviceHeight * 0.7,
        child: GestureDetector(
          onTap: () {
            context.read<CameraCubit>().takePicture();
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appColorScheme(context).primary,
            ),
            width: context.deviceWidth * 0.23,
            height: context.deviceWidth * 0.23,
          ),
        ),
      );
    }

    Widget featureBottomCameraSection() {
      return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.photo_library_outlined,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                'POST',
                style: appTextTheme(
                  context,
                ).titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  context.read<CameraCubit>().switchCamera();
                },
                icon: Icon(
                  Icons.cameraswitch_outlined,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return BlocConsumer<CameraCubit, CameraState>(
      listener: (context, state) {
        if (state.status.isError) {
          AppTopSnackBar(context).showDanger(state.errorMessage);
        }

        if (state.status.isTakePicture) {
          AppTopSnackBar(context).showSuccess('Picture taken successfully');
          final PreviewStoryRequestModel data = PreviewStoryRequestModel(
            imagePicked: state.image,
          );
          context.push(RoutesName.addDetailPost, extra: data);
        }
      },
      builder: (context, state) {
        return AppLoading(
          isLoading: state.status.isTakePictureLoading,
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    width: context.deviceWidth,
                    height: context.deviceHeight,
                  ),
                  cameraViewSection(),
                  featureHeaderCameraSection(),
                  buttonCaptureSection(),
                  featureBottomCameraSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
