import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/feature/splash/cubit/bottom_index/bottom_index_cubit.dart';
import 'package:story_app/feature/splash/view/main_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/main');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomIndexCubit(),
      child: const MainView(),
    );
  }
}
