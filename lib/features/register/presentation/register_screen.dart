
import 'package:fakebook/features/register/presentation/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.paddingMedium),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hello!', style: AppTextStyles.headline1),
                  const SizedBox(height: AppSpacing.paddingSmall),
                  Text(
                    'Sign up to communicate with your friends',
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.paddingLarge),
                  CustomFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Name must not be empty'
                        : null,
                    label: 'Name',
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(height: AppSpacing.paddingMedium),
                  CustomFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Email must not be empty'
                        : null,
                    label: 'Email',
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: AppSpacing.paddingMedium),
                  CustomFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Phone must not be empty'
                        : null,
                    label: 'Phone',
                    prefixIcon: Icons.phone,
                  ),
                  const SizedBox(height: AppSpacing.paddingMedium),
                  Consumer(builder: (context, ref, _) {
                    final passwordVisibility =
                        ref.watch(registerPasswordVisibilityProvider);
                    return CustomFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Password must not be empty'
                          : null,
                      obscureText: !passwordVisibility,
                      suffixIcon: passwordVisibility
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      onSuffixIconPressed: () {
                        registerTogglePasswordVisibility(ref);
                      },
                      prefixIcon: Icons.lock_outline,
                      label: 'Password',
                    );
                  }),
                  const SizedBox(height: AppSpacing.paddingLarge),
                  Consumer(builder: (context, ref, _) {
                    final loadingState = ref.watch(registerLoadingProvider);
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
                          if (formKey.currentState!.validate()) {
                            ref.watch(registerLoadingProvider.notifier).state =
                                true;

                            try {
                              await ref.read(registerProvider(RegisterRequest(
                                      nameController.text.trim(),
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                      phoneController.text.trim()))
                                  .future);
                              context.push(Routes.home);
                            } catch (e) {
                              throw Exception(e.toString());
                            } finally {
                              ref
                                  .watch(registerLoadingProvider.notifier)
                                  .state = false;
                            }
                          }
                        },
                        child: loadingState
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'SIGN UP',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                      ),
                    );
                  }),
                  const SizedBox(height: AppSpacing.paddingMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: AppTextStyles.body.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => context.push(Routes.login),
                        child: const Text(
                          'Sign In',
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
      ),
    );
  }
}
