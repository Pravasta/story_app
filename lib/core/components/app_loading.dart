import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:story_app/core/theme/app_color.dart';
import 'package:story_app/core/utils/assets.gen.dart';
import 'package:story_app/main.dart';

class AppLoading extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? label;

  const AppLoading({
    super.key,
    required this.isLoading,
    required this.child,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: AppColor.black.withOpacity(0.6),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        Assets.lottie.loading,
                        width: 112,
                        height: 50,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        label ?? 'Mohon tunggu, ya..',
                        textAlign: TextAlign.center,
                        style: appTextTheme(
                          context,
                        ).bodySmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
