import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/components/app_button.dart';
import 'package:story_app/core/components/app_loading.dart';
import 'package:story_app/core/components/app_text_field.dart';
import 'package:story_app/core/components/app_top_snackbar.dart';
import 'package:story_app/core/model/request/login_request_model.dart';
import 'package:story_app/core/routes/routes_name.dart';
import 'package:story_app/core/theme/app_color.dart';
import 'package:story_app/core/utils/global_state.dart';
import 'package:story_app/feature/auth/logic/login/login_cubit.dart';
import 'package:story_app/main.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isObsecure = true;

  @override
  void initState() {
    _emailController = TextEditingController(text: 'akunkhusus@gmail.com');
    _passwordController = TextEditingController(text: 'Admin123');
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget headerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login to your account!',
          style: appTextTheme(context).displayMedium,
        ),
        SizedBox(height: 20),
        Text(
          'With login you can access all the features of the app and enjoy the content.',
          style: appTextTheme(context).bodyMedium,
        ),
      ],
    );
  }

  Widget emailFieldSection() {
    return AppValidatorTextField(
      controller: _emailController,
      labelText: 'Email Address',
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
          labelText: 'Password',

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
          isObscure: _isObsecure,
          suffixWidget: IconButton(
            onPressed: () {
              setState(() {
                _isObsecure = !_isObsecure;
              });
            },
            icon: Icon(
              _isObsecure ? Icons.visibility : Icons.visibility_off,
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
    return AppButton(
      title: 'Login',
      onTap: () {
        final data = LoginRequestModel(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (_formKey.currentState!.validate()) {
          context.read<LoginCubit>().login(data);
        }
      },
      height: 50,
      titleColor: appColorScheme(context).primary,
      borderColor: appColorScheme(context).secondary,
      backgroundColor: appColorScheme(context).primaryContainer,
    );
  }

  Widget registerButtonSection() {
    return RichText(
      text: TextSpan(
        text: 'Don\'t have an account? ',
        style: appTextTheme(context).bodySmall,
        children: [
          TextSpan(
            text: 'Register',
            style: appTextTheme(context).bodySmall!.copyWith(
              color: appColorScheme(context).primary,
              fontWeight: FontWeight.bold,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    context.push(RoutesName.register);
                  },
          ),
        ],
      ),
    );
  }

  Widget bottomSection() {
    return Text(
      'By logging in, you agree to our Terms of Service and Privacy Policy.',
      textAlign: TextAlign.center,
      style: appTextTheme(context).labelMedium,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.globalState.isFailed) {
          AppTopSnackBar(context).showDanger(state.message);
        }

        if (state.globalState.isSuccessSubmit) {
          AppTopSnackBar(context).showSuccess(
            'Login successful, welcome ${state.loginResult?.name ?? ''}',
          );
          context.go(RoutesName.mainPage);
        }
      },
      builder: (context, state) {
        return AppLoading(
          isLoading: state.globalState.isLoading,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        headerSection(),
                        SizedBox(height: 40),
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
          ),
        );
      },
    );
  }
}
