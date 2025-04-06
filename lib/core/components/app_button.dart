import 'package:story_app/core/theme/app_color.dart';
import 'package:story_app/main.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.titleColor = AppColor.white,
    this.width = double.infinity,
    this.height = 0,
    this.padding = 15,
    this.backgroundColor,
    this.borderColor = AppColor.accent,
    required this.onTap,
    this.elevation = 3,
    this.iconUrl,
    this.borderRadius = 10,
  });

  final String title;
  final Color? titleColor;
  final double padding, width, height;
  final Color? backgroundColor;
  final Color borderColor;
  final Function() onTap;
  final double elevation;
  final String? iconUrl;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(padding),
        elevation: elevation,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: backgroundColor,
      ),
      onPressed: onTap,
      child:
          iconUrl != null
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(iconUrl!, width: 20),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: appTextTheme(context).bodyMedium!.copyWith(
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
              : Text(
                title,
                style: appTextTheme(context).bodyMedium!.copyWith(
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
    );
  }
}
