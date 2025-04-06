import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/components/app_shimmer.dart';
import 'package:story_app/core/extensions/build_context_ext.dart';
import 'package:story_app/core/extensions/date_time_ext.dart';
import 'package:story_app/feature/detail_story/cubit/get_detail_story_cubit.dart';
import 'package:story_app/main.dart';

import '../../../core/components/app_image.dart';
import '../../../core/utils/assets.gen.dart';

class DetailStoryView extends StatelessWidget {
  const DetailStoryView({super.key, required this.storyId});

  final String storyId;

  @override
  Widget build(BuildContext context) {
    AppBar appBar() {
      return AppBar(
        leading: BackButton(
          color: appColorScheme(context).primary,
          onPressed: () {
            context.pop();
          },
        ),
        title: Text('Post', style: appTextTheme(context).displaySmall),
      );
    }

    Widget contentSection() {
      return BlocBuilder<GetDetailStoryCubit, GetDetailStoryState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return AppShimmer(
              context.deviceHeight * 0.4,
              context.deviceWidth,
              0,
            );
          }
          if (state.status.isError) {
            return Center(
              child: Text(
                state.message,
                style: appTextTheme(context).bodyLarge,
              ),
            );
          }

          if (state.status.isSuccess) {
            final story = state.story;

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
                              story?.name ?? '',
                              style: appTextTheme(context).labelLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              story?.lat != null && story?.lon != null
                                  ? '${story?.lat}, ${story?.lon}'
                                  : 'Location not available',
                              style: appTextTheme(context).labelLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppImage(
                    imageUrl: story?.photoUrl ?? '',
                    width: context.deviceWidth,
                    height: context.deviceHeight * 0.27,
                  ),

                  SizedBox(height: 5),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                          size: 25,
                          color: appColorScheme(context).primary,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.comment_outlined,
                          size: 25,
                          color: appColorScheme(context).primary,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          size: 25,
                          color: appColorScheme(context).primary,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
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
                          story?.description ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: appTextTheme(
                            context,
                          ).labelLarge!.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),

                        Text(
                          story?.createdAt!.toFormattedTimeAgo() ?? '',
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

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'No data available',
                style: appTextTheme(context).bodyLarge,
              ),
            ),
          );
        },
      );
    }

    return Scaffold(appBar: appBar(), body: contentSection());
  }
}
