import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/common/common.dart';
import 'package:story_app/core/components/app_top_snackbar.dart';
import 'package:story_app/core/extensions/build_context_ext.dart';
import 'package:story_app/core/logic/app_permissions/app_permissions_cubit.dart';
import 'package:story_app/core/routes/routes_name.dart';
import 'package:story_app/core/theme/app_color.dart';
import 'package:story_app/feature/add_story/cubit/fetch_image_gallery/fetch_image_gallery_cubit.dart';
import 'package:story_app/main.dart';

import '../../../core/model/request/preview_story_request_model.dart';

class AddStoryView extends StatefulWidget {
  const AddStoryView({super.key});

  @override
  State<AddStoryView> createState() => _AddStoryViewState();
}

class _AddStoryViewState extends State<AddStoryView> {
  bool _isCover = false;
  XFile? pickImage;

  @override
  void initState() {
    context.read<AppPermissionsCubit>()
      ..checkGalleryPermission()
      ..checkCameraPermission();
    context.read<FetchImageGalleryCubit>().fetchImageGallery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar() {
      return AppBar(
        leading: BackButton(
          onPressed: () {
            context.pushReplacement(RoutesName.mainPage);
          },
          color: Theme.of(context).colorScheme.primary,
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.new_story,
          style: appTextTheme(context).displaySmall,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (pickImage == null) {
                AppTopSnackBar(context).showDanger('Please select image first');
              } else {
                final data = PreviewStoryRequestModel(
                  imagePicked: pickImage,
                  isCover: _isCover,
                );

                context.push(RoutesName.addDetailPost, extra: data);
              }
            },
            child: Text(
              AppLocalizations.of(context)!.next,
              style: appTextTheme(context).bodyMedium!.copyWith(
                color: appColorScheme(context).primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }

    Widget contentImageSection() {
      return BlocBuilder<FetchImageGalleryCubit, FetchImageGalleryState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status.isFailure) {
            return Center(
              child: Text(
                state.message,
                style: appTextTheme(context).displayMedium,
              ),
            );
          }

          return Container(
            width: context.deviceWidth,
            color: appColorScheme(context).onPrimary,
            child:
                state.selectedImage != null
                    ? Image.file(
                      File(state.selectedImage!.path),
                      fit: _isCover ? BoxFit.cover : BoxFit.contain,
                    )
                    : Center(
                      child: Text(
                        AppLocalizations.of(context)!.no_selected_image,
                        style: appTextTheme(context).displayMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
          );
        },
      );
    }

    Widget featureButtonSection() {
      return Container(
        padding: const EdgeInsets.all(10),
        color: appColorScheme(context).onPrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColor.neutral[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                AppTopSnackBar(
                  context,
                ).showInfo(AppLocalizations.of(context)!.feature_not_available);
              },
              child: Text(
                AppLocalizations.of(context)!.select_multiple_image,
                style: appTextTheme(context).titleMedium!.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColor.neutral[500],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isCover = !_isCover;
                    });
                  },
                  icon: Icon(
                    Icons.crop_landscape_rounded,
                    size: 25,
                    color: AppColor.white,
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColor.neutral[500],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  onPressed: () {
                    context.push(RoutesName.cameraPage);
                  },
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 25,
                    color: AppColor.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget imageGaleryViewSection() {
      return BlocBuilder<FetchImageGalleryCubit, FetchImageGalleryState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status.isFailure) {
            return Center(
              child: Text(
                state.message,
                style: appTextTheme(context).displayMedium,
              ),
            );
          }

          if (state.status.isSuccess) {
            final images = state.assets;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                final isSelected = images[index] == state.selectedImage;

                return GestureDetector(
                  onTap: () {
                    pickImage = images[index];
                    context.read<FetchImageGalleryCubit>().selectImage(
                      images[index],
                    );
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(images[index]!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (isSelected)
                        Container(color: AppColor.neutral.withOpacity(0.7)),
                    ],
                  ),
                );
              },
            );
          }

          return SizedBox();
        },
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              automaticallyImplyLeading: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              flexibleSpace: FlexibleSpaceBar(
                background: contentImageSection(),
              ),
            ),

            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              toolbarHeight: 60,
              titleSpacing: 0,
              title: featureButtonSection(),
              automaticallyImplyLeading: false,
            ),
          ];
        },
        body: imageGaleryViewSection(),
      ),
    );
  }
}
