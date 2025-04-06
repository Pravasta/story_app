import 'package:flutter/material.dart';
import 'package:story_app/core/components/app_image.dart';
import 'package:story_app/core/components/app_top_snackbar.dart';
import 'package:story_app/core/extensions/build_context_ext.dart';
import 'package:story_app/core/extensions/date_time_ext.dart';
import 'package:story_app/core/model/response/get_all_stories_response_model.dart';
import 'package:story_app/core/utils/assets.gen.dart';
import 'package:story_app/main.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({super.key, required this.story});

  final ListStory story;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColorScheme(context).onPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(Assets.icons.avatar.path, scale: 3),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.name ?? '',
                      style: appTextTheme(
                        context,
                      ).labelLarge!.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      story.lat != null && story.lon != null
                          ? '${story.lat}, ${story.lon}'
                          : 'Location not available',
                      style: appTextTheme(
                        context,
                      ).labelLarge!.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppImage(
            imageUrl: story.photoUrl ?? '',
            width: context.deviceWidth,
            height: context.deviceHeight * 0.27,
          ),

          SizedBox(height: 5),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  AppTopSnackBar(
                    context,
                  ).showInfo('This feature is not available yet');
                },
                icon: Icon(
                  Icons.favorite_border,
                  size: 25,
                  color: appColorScheme(context).primary,
                ),
              ),
              IconButton(
                onPressed: () {
                  AppTopSnackBar(
                    context,
                  ).showInfo('This feature is not available yet');
                },
                icon: Icon(
                  Icons.comment_outlined,
                  size: 25,
                  color: appColorScheme(context).primary,
                ),
              ),
              IconButton(
                onPressed: () {
                  AppTopSnackBar(
                    context,
                  ).showInfo('This feature is not available yet');
                },
                icon: Icon(
                  Icons.share,
                  size: 25,
                  color: appColorScheme(context).primary,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  AppTopSnackBar(
                    context,
                  ).showInfo('This feature is not available yet');
                },
                icon: Icon(
                  Icons.bookmark_border_outlined,
                  size: 25,
                  color: appColorScheme(context).primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '112,099 Likes',
                  style: appTextTheme(
                    context,
                  ).labelLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  story.description ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: appTextTheme(
                    context,
                  ).labelLarge!.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  story.createdAt!.toFormattedTimeAgo(),
                  style: appTextTheme(
                    context,
                  ).labelSmall!.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
