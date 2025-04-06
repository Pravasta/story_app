import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/routes/routes_name.dart';
import 'package:story_app/feature/splash/cubit/bottom_index/bottom_index_cubit.dart';
import 'package:story_app/feature/splash/model/main_page_model.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomIndexCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: MainPageModel.listMainPage
              .map((e) => e.page)
              .toList()
              .elementAt(currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              if (index == 1) {
                context.push(RoutesName.addPost);
              }
              context.read<BottomIndexCubit>().changeBottomIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items:
                MainPageModel.listMainPage
                    .map(
                      (e) => BottomNavigationBarItem(
                        icon: Icon(e.icon, size: 35),
                        label: e.label,
                      ),
                    )
                    .toList(),
          ),
        );
      },
    );
  }
}
