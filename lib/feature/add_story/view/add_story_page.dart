import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/add_story/cubit/fetch_image_gallery/fetch_image_gallery_cubit.dart';
import 'package:story_app/feature/add_story/repository/add_story_repository.dart';

import 'add_story_view.dart';

class AddStoryPage extends StatelessWidget {
  const AddStoryPage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/addStory');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FetchImageGalleryCubit(AddStoryRepositoryImpl.create()),
      child: AddStoryView(),
    );
  }
}
