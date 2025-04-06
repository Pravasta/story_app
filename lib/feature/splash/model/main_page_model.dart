import 'package:flutter/material.dart';
import '../../add_story/view/add_story_page.dart';
import '../../home/view/home_page.dart';
import '../../profile/view/profile_page.dart';

class MainPageModel {
  final String label;
  final IconData icon;
  final Widget page;
  final int index;

  const MainPageModel({
    required this.label,
    required this.icon,
    required this.page,
    required this.index,
  });

  static List<MainPageModel> listMainPage = [
    MainPageModel(
      label: 'Home',
      icon: Icons.home_filled,
      page: HomePage(),
      index: 0,
    ),
    MainPageModel(
      label: 'Add',
      icon: Icons.add_box_outlined,
      page: AddStoryPage(),
      index: 1,
    ),
    MainPageModel(
      label: 'Profile',
      icon: Icons.person_outlined,
      page: ProfilePage(),
      index: 2,
    ),
  ];
}
