import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/detail_story/cubit/get_detail_story_cubit.dart';
import 'package:story_app/feature/detail_story/repository/detail_repository.dart';
import 'detail_story_view.dart';

class DetailStoryPage extends StatelessWidget {
  const DetailStoryPage({super.key, required this.storyId});

  static const RouteSettings routeSettings = RouteSettings(
    name: '/detail-story',
  );

  final String storyId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              GetDetailStoryCubit(DetailRepositoryImpl.create())
                ..getDetailStory(storyId),
      child: DetailStoryView(storyId: storyId),
    );
  }
}
