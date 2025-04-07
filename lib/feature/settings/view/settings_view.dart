import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/common/common.dart';
import 'package:story_app/core/components/app_button.dart';
import 'package:story_app/core/components/app_loading.dart';
import 'package:story_app/core/components/app_top_snackbar.dart';
import 'package:story_app/core/routes/routes_name.dart';
import 'package:story_app/core/utils/global_state.dart';
import 'package:story_app/feature/settings/cubit/logout/logout_cubit.dart';
import 'package:story_app/main.dart';

import '../../../core/logic/change_theme/change_theme_cubit.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar() {
      return AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings_and_privacy,
          style: appTextTheme(context).bodyMedium?.copyWith(
            color: appColorScheme(context).primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      );
    }

    Widget changeThemeFeature() {
      return BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
        builder: (context, state) {
          return ListTile(
            title: Text(
              'Change Theme',
              style: appTextTheme(context).bodyMedium?.copyWith(
                color: appColorScheme(context).primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Switch(
              value: state.isDarkMode,
              onChanged: (value) {
                context.read<ChangeThemeCubit>().setTheme(value);
              },
            ),
          );
        },
      );
    }

    Widget buttonLogout() {
      return AppButton(
        title: AppLocalizations.of(context)!.logout,
        onTap: () {
          context.read<LogoutCubit>().logout();
        },
        backgroundColor: appColorScheme(context).error,
      );
    }

    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state.state.isFailed) {
          AppTopSnackBar(context).showDanger(state.message);
        }

        if (state.state.isSuccessSubmit) {
          AppTopSnackBar(context).showSuccess(state.message);
          context.go(RoutesName.login);
        }
      },
      builder: (context, state) {
        return AppLoading(
          isLoading: state.state.isLoading,
          child: Scaffold(
            appBar: appBar(),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [changeThemeFeature(), buttonLogout()]),
            ),
          ),
        );
      },
    );
  }
}
