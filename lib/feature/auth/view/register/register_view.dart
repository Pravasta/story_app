import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/common/common.dart';
import 'package:story_app/core/components/app_button.dart';
import 'package:story_app/core/components/app_text_field.dart';
import 'package:story_app/core/components/app_top_snackbar.dart';
import 'package:story_app/core/model/request/register_request_model.dart';
import 'package:story_app/core/theme/app_color.dart';
import 'package:story_app/core/utils/global_state.dart';
import 'package:story_app/feature/auth/logic/register/register_cubit.dart';
import 'package:story_app/main.dart';

import '../../../../core/components/app_loading.dart';
import '../../../../core/logic/language/language_cubit.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Widget headerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.register_appbar,
          style: appTextTheme(context).displayMedium,
        ),
        SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)!.register_description,
          style: appTextTheme(context).bodyMedium,
        ),
      ],
    );
  }

  Widget nameFieldSection() {
    return AppValidatorTextField(
      controller: _nameController,
      labelText: AppLocalizations.of(context)!.fullname,
      hintText: 'Enter your full name',
      prefixIcon: const Icon(Icons.person_outline),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        if (value.length < 3) {
          return 'Name must be at least 3 characters long';
        }
        return null;
      },
      contentPadding: ContentPadding.all16,
      inputType: TextInputType.name,
    );
  }

  Widget emailFieldSection() {
    return AppValidatorTextField(
      controller: _emailController,
      labelText: AppLocalizations.of(context)!.email,
      hintText: 'Enter your email address',
      prefixIcon: const Icon(Icons.email_outlined),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        }
        if (!value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      contentPadding: ContentPadding.all16,
      inputType: TextInputType.emailAddress,
    );
  }

  Widget passwordFieldSection() {
    return StatefulBuilder(
      builder: (context, setState) {
        return AppValidatorTextField(
          controller: _passwordController,
          labelText: AppLocalizations.of(context)!.password,
          hintText: 'Enter your password',
          prefixIcon: const Icon(Icons.lock_outline),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 8) {
              return 'Password must be at least 8 characters long';
            }
            return null;
          },
          isObscure: _isObscure,
          suffixWidget: IconButton(
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
              color: AppColor.black,
            ),
          ),
          contentPadding: ContentPadding.all16,
          inputType: TextInputType.visiblePassword,
        );
      },
    );
  }

  Widget buttonSubmitSection() {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.globalState.isFailed) {
          AppTopSnackBar(context).showDanger(state.message);
        }

        if (state.globalState.isSuccessSubmit) {
          AppTopSnackBar(context).showSuccess(state.message);
          context.pop();
        }
      },
      builder: (context, state) {
        if (state.globalState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return AppButton(
          title: AppLocalizations.of(context)!.register,
          onTap: () {
            if (_formKey.currentState!.validate()) {
              final data = RegisterRequestModel(
                name: _nameController.text.trim(),
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
              );

              context.read<RegisterCubit>().register(data);
            }
          },
          height: 50,
          titleColor: appColorScheme(context).primary,
          borderColor: appColorScheme(context).secondary,
          backgroundColor: appColorScheme(context).primaryContainer,
        );
      },
    );
  }

  Widget registerButtonSection() {
    return RichText(
      text: TextSpan(
        text: AppLocalizations.of(context)!.already_have_account,
        style: appTextTheme(context).bodySmall,
        children: [
          TextSpan(
            text: ' ${AppLocalizations.of(context)!.login}',
            style: appTextTheme(context).bodySmall!.copyWith(
              color: appColorScheme(context).primary,
              fontWeight: FontWeight.bold,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    context.pop();
                  },
          ),
        ],
      ),
    );
  }

  Widget bottomSection() {
    return Text(
      AppLocalizations.of(context)!.terms_and_conditions,
      textAlign: TextAlign.center,
      style: appTextTheme(context).bodySmall,
    );
  }

  Widget changeLanguageSection() {
    return BlocConsumer<LanguageCubit, LanguageState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          AppTopSnackBar(context).showDanger(state.error);
        }

        if (state.status.isSuccess) {
          AppTopSnackBar(
            context,
          ).showSuccess("Language changed to ${state.languageCode}");
        }
      },
      builder: (context, state) {
        return AppLoading(
          isLoading: state.status.isLoading,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: state.languageCode,
                items: [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text(
                      'English',
                      style: appTextTheme(context).bodySmall,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'id',
                    child: Text(
                      'Indonesia',
                      style: appTextTheme(context).bodySmall,
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    context.read<LanguageCubit>().setLanguage(value);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  changeLanguageSection(),
                  SizedBox(height: 10),
                  headerSection(),
                  SizedBox(height: 40),
                  nameFieldSection(),
                  SizedBox(height: 20),
                  emailFieldSection(),
                  SizedBox(height: 20),
                  passwordFieldSection(),
                  SizedBox(height: 40),
                  buttonSubmitSection(),
                  SizedBox(height: 20),
                  registerButtonSection(),
                  SizedBox(height: 20),
                  bottomSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
