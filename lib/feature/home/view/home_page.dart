import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/home/cubit/get_all_stories/get_all_stories_cubit.dart';
import 'package:story_app/feature/home/repository/home_repository.dart';

import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              GetAllStoriesCubit(HomeRepositoryImpl.create())..getAllStories(),
      child: const HomeView(),
    );
  }
}
