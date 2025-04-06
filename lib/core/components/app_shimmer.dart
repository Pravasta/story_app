import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_color.dart';

class AppShimmer extends StatelessWidget {
  final double? height, width, rounded;
  final EdgeInsetsGeometry? margin;
  const AppShimmer(
    this.height,
    this.width,
    this.rounded, {
    super.key,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.white,
      highlightColor: AppColor.black,
      child: Container(
        height: height ?? 30,
        width: width ?? 100,
        margin: margin ?? const EdgeInsets.only(bottom: 3.0),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(rounded ?? 0),
        ),
      ),
    );
  }
}
