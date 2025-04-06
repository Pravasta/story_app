import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/extensions/build_context_ext.dart';
import 'package:story_app/core/model/response/login_response_model.dart';
import 'package:story_app/core/routes/routes_name.dart';
import 'package:story_app/core/utils/assets.gen.dart';
import 'package:story_app/feature/profile/cubit/get_profile/get_profile_cubit.dart';
import 'package:story_app/main.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    Widget headerSection(LoginResult? data) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(Assets.images.profileMe.path),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data?.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appTextTheme(
                      context,
                    ).titleLarge!.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    data?.userId ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appTextTheme(
                      context,
                    ).labelLarge!.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                context.push(RoutesName.settings);
              },
              child: Icon(
                Icons.settings_outlined,
                size: 30,
                color: appColorScheme(context).primary,
              ),
            ),
          ],
        ),
      );
    }

    Widget descriptionSection(LoginResult? data) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data?.name ?? '',
              style: appTextTheme(
                context,
              ).titleSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: appTextTheme(
                context,
              ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }

    Widget infoPostSection(LoginResult? data) {
      return Container(
        width: context.deviceWidth,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: appColorScheme(context).primary,
            width: 0.1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('112', style: appTextTheme(context).headlineSmall),
                Text('Posts', style: appTextTheme(context).labelLarge),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                Text('1,112', style: appTextTheme(context).headlineSmall),
                Text('Followers', style: appTextTheme(context).labelLarge),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                Text('112', style: appTextTheme(context).headlineSmall),
                Text('Following', style: appTextTheme(context).labelLarge),
              ],
            ),
          ],
        ),
      );
    }

    Widget listPostSection(LoginResult? data) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.dummyPost2.path),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<GetProfileCubit, GetProfileState>(
            builder: (context, state) {
              final data = state.loginResult;
              if (state.status.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status.isError) {
                return Center(child: Text(state.message));
              }

              if (state.status.isSuccess) {
                return Column(
                  children: [
                    headerSection(data),
                    const SizedBox(height: 20),
                    descriptionSection(data),
                    const SizedBox(height: 20),
                    infoPostSection(data),
                    const SizedBox(height: 20),
                    listPostSection(data),
                  ],
                );
              }

              return const Center(child: Text('No data available'));
            },
          ),
        ),
      ),
    );
  }
}
