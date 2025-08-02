
import 'package:fakebook/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/default_form_field.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          context.push(Routes.home);
        } else if (state is LoginErrorState) {
          toast(msg: state.error);
        }
      },
      builder: (context, state) {

        final cubit = LoginCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingMedium,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: AppTextStyles.headline1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.paddingSmall),
                    Text(
                      'Login to access your account',
                      style: AppTextStyles.body,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    defaultFormField(
                      controller: _emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) =>
                      value.isEmpty ? 'Email must not be empty' : null,
                      prefixIcon: Icons.email,
                      label: 'Email',
                    ),
                    const SizedBox(height: AppSpacing.paddingMedium),

                    defaultFormField(
                      controller: _passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (value) =>
                      value.isEmpty ? 'Password must not be empty' : null,
                      isPassword: cubit.isPasswordVisible,
                      suffixIcon: cubit.isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      suffixIconPressed: cubit.togglePasswordVisibility,
                      prefixIcon: Icons.lock_outline,
                      label: 'Password',
                    ),
                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.login(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );
                          }
                        },
                        child: state is LoginLoadingState
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          'LOGIN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.paddingMedium),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: AppTextStyles.body.copyWith(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () => context.push(Routes.register),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
