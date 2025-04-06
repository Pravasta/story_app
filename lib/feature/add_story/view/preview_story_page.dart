import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/components/app_button.dart';
import 'package:story_app/core/components/app_loading.dart';
import 'package:story_app/core/components/app_top_snackbar.dart';
import 'package:story_app/core/extensions/build_context_ext.dart';
import 'package:story_app/core/model/request/add_new_story_request_model.dart';
import 'package:story_app/core/model/request/preview_story_request_model.dart';
import 'package:story_app/core/routes/routes_name.dart';
import 'package:story_app/core/utils/global_state.dart';
import 'package:story_app/feature/add_story/cubit/add_new_story/add_new_story_cubit.dart';
import 'package:story_app/feature/home/cubit/get_all_stories/get_all_stories_cubit.dart';

import '../../../main.dart';

class PreviewStoryPage extends StatefulWidget {
  const PreviewStoryPage({super.key, required this.data});

  final PreviewStoryRequestModel data;

  @override
  State<PreviewStoryPage> createState() => _PreviewStoryPageState();
}

class _PreviewStoryPageState extends State<PreviewStoryPage> {
  late TextEditingController _descriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar() {
      return AppBar(
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
          color: Theme.of(context).colorScheme.primary,
        ),
        centerTitle: true,
        title: Text('New Story', style: appTextTheme(context).displaySmall),
      );
    }

    Widget contentImageSection() {
      return SizedBox(
        width: context.deviceWidth,
        height: context.deviceHeight * 0.4,

        child:
            widget.data.imagePicked != null
                ? Image.file(
                  File(widget.data.imagePicked!.path),
                  fit: widget.data.isCover ? BoxFit.cover : BoxFit.contain,
                )
                : const Center(child: Text('No image selected')),
      );
    }

    Widget captionFieldSection() {
      return TextFormField(
        maxLines: 5,
        minLines: 1,
        controller: _descriptionController,
        decoration: InputDecoration(
          hintText: 'Write a caption...',
          hintStyle: appTextTheme(
            context,
          ).bodyMedium!.copyWith(color: appColorScheme(context).primary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a caption';
          }
          return null;
        },
        style: appTextTheme(
          context,
        ).bodyMedium!.copyWith(color: appColorScheme(context).primary),
      );
    }

    Widget addLocationSection() {
      return GestureDetector(
        onTap: () {
          AppTopSnackBar(context).showDanger('Feature not available yet');
        },
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: appColorScheme(context).primary,
              size: 40,
            ),
            const SizedBox(width: 10),
            Text(
              'Add location',
              style: appTextTheme(
                context,
              ).bodyMedium!.copyWith(color: appColorScheme(context).primary),
            ),
          ],
        ),
      );
    }

    Widget addMussicSection() {
      return GestureDetector(
        onTap: () {
          AppTopSnackBar(context).showDanger('Feature not available yet');
        },
        child: Row(
          children: [
            Icon(
              Icons.music_note_outlined,
              color: appColorScheme(context).primary,
              size: 40,
            ),
            const SizedBox(width: 10),
            Text(
              'Add music',
              style: appTextTheme(
                context,
              ).bodyMedium!.copyWith(color: appColorScheme(context).primary),
            ),
          ],
        ),
      );
    }

    Widget buttonPostSection() {
      return AppButton(
        title: 'Post',
        onTap: () {
          final data = AddNewStoryRequestModel(
            description: _descriptionController.text.trim(),
            photo: File(widget.data.imagePicked!.path),
            latitude: 0,
            longitude: 0,
          );
          if (_formKey.currentState!.validate()) {
            context.read<AddNewStoryCubit>().addNewStory(data);
          }
        },
        titleColor: appColorScheme(context).primary,
        borderColor: appColorScheme(context).secondary,
        backgroundColor: appColorScheme(context).primaryContainer,
      );
    }

    return BlocConsumer<AddNewStoryCubit, AddNewStoryState>(
      listener: (context, state) {
        if (state.status.isFailed) {
          AppTopSnackBar(context).showDanger(state.message);
        }
        if (state.status.isSuccessSubmit) {
          AppTopSnackBar(context).showSuccess(state.message);
          context.read<GetAllStoriesCubit>().getAllStories();
          context.pushReplacement(RoutesName.mainPage);
        }
      },
      builder: (context, state) {
        return AppLoading(
          isLoading: state.status.isLoading,
          child: Scaffold(
            appBar: appBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      contentImageSection(),
                      SizedBox(height: 20),
                      captionFieldSection(),
                      SizedBox(height: 20),
                      addLocationSection(),
                      SizedBox(height: 20),
                      addMussicSection(),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: Container(
              width: context.deviceWidth,
              padding: const EdgeInsets.all(20),
              child: buttonPostSection(),
            ),
          ),
        );
      },
    );
  }
}
