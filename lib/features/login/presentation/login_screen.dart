
import 'package:fakebook/core/routing/routes.dart';
import 'package:fakebook/core/widgets/components.dart';
import 'package:fakebook/features/login/presentation/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_form_field.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

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
                const SizedBox(height: AppSpacing.paddingLarge),
                CustomFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Email must not be empty'
                      : null,
                  label: 'Email',
                ),
                const SizedBox(height: 16.0),
                Consumer(
                  builder: (context , ref, _){
                    final passwordVisibilityState = ref.watch(loginPasswordVisibilityProvider);
                    return CustomFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Password must not be empty'
                          : null,
                      obscureText: !passwordVisibilityState,
                      suffixIcon: passwordVisibilityState
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      onSuffixIconPressed: () {
                        loginTogglePasswordVisibility(ref);
                      },
                      prefixIcon: Icons.lock_outline,
                      label: 'Password',
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.paddingLarge),
                Consumer(
                    builder: (context, ref, _){
                      final isLoading = ref.watch(loginLoadingProvider);
                      return SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusMedium,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ref.read(loginLoadingProvider.notifier).state = true;
                              try {
                                await ref.read(
                                  loginProvider(
                                    LoginRequest(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  ).future,
                                );
                                context.push(Routes.home);
                              } catch (e) {
                                toast(msg: e.toString());
                              } finally {
                                ref.read(loginLoadingProvider.notifier).state = false;
                              }
                            }
                          },
                          child: isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                            'LOGIN',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                ),
                const SizedBox(height: AppSpacing.paddingLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: AppTextStyles.body.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => context.push(Routes.register),
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
  }
}
