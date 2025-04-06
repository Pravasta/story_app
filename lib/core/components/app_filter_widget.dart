import 'package:flutter/material.dart';

import '../theme/app_color.dart';

class AppFilterWidget extends StatelessWidget {
  const AppFilterWidget(this.onTap, {this.color, super.key});

  final void Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 45.0,
        height: 45.0,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color ?? AppColor.neutral[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.filter_list_rounded, color: AppColor.white),
      ),
    );
  }
}
