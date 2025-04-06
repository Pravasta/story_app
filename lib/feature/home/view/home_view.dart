import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/components/app_shimmer.dart';
import 'package:story_app/core/components/app_top_snackbar.dart';
import 'package:story_app/core/extensions/build_context_ext.dart';
import 'package:story_app/core/routes/routes_name.dart';
import 'package:story_app/feature/home/cubit/get_all_stories/get_all_stories_cubit.dart';
import 'package:story_app/feature/home/view/widget/post_card_widget.dart';
import 'package:story_app/main.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar() {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appColorScheme(context).onPrimary,
        title: Text('Story App', style: appTextTheme(context).displaySmall),
        actions: [
          GestureDetector(
            onTap: () => context.push(RoutesName.addPost),
            child: Icon(
              Icons.add_box_outlined,
              size: 30,
              color: appColorScheme(context).primary,
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap:
                () => AppTopSnackBar(
                  context,
                ).showInfo('This feature is not available yet'),
            child: Icon(
              Icons.favorite_border,
              size: 30,
              color: appColorScheme(context).primary,
            ),
          ),
          SizedBox(width: 10),
        ],
      );
    }

    Widget content() {
      return BlocBuilder<GetAllStoriesCubit, GetAllStoriesState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return AppShimmer(
                  context.deviceHeight * 0.3,
                  context.deviceWidth,
                  0,
                );
              },
            );
          }

          if (state.status.isError) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  state.message,
                  style: appTextTheme(context).bodyLarge,
                ),
              ),
            );
          }

          if (state.status.isSuccess) {
            final stories = state.listStory;

            if (stories.isEmpty) {
              return Center(
                child: Text(
                  'No stories available',
                  style: appTextTheme(context).bodyLarge,
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];

                return GestureDetector(
                  onTap: () {
                    context.push(
                      '${RoutesName.detailPost}/${story.id}',
                      extra: story.id,
                    );
                  },
                  child: PostCardWidget(story: story),
                );
              },
            );
          }

          return Center(
            child: Text(
              'Something went wrong',
              style: appTextTheme(context).bodyLarge,
            ),
          );
        },
      );
    }

    return Scaffold(appBar: appBar(), body: content());
  }
}
