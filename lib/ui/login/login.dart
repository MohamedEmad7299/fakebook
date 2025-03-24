
import 'package:fakebook/ui/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/funs.dart';
import '../sign_up/sign_up_screen.dart';
import '../widgets/default_form_field.dart';
import 'cubit/cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {

        if (state is LoginSuccessState) {

          toast(msg: 'Donoo');

        } else if (state is LoginErrorState) {
          toast(msg: state.error);
        }
      }, builder: (context, state) {

        var cubit = LoginCubit.get(context);
        return Scaffold(
            appBar: AppBar(),
            body: Container(
              padding: EdgeInsetsDirectional.only(start: 16, end: 16),
              width: double.infinity,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Login to access your account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 32),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      prefixIcon: Icons.email,
                      label: 'Email',
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Password must not be empty';
                        }
                        return null;
                      },
                      isPassword: cubit.isPassword,
                      suffixIconPressed: () {
                        cubit.changePasswordVisibility();
                      },
                      suffixIcon: cubit.isPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      prefixIcon: Icons.lock_outline,
                      label: 'Password',
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: double.infinity, // Set width
                      height: 60, // Set height
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.loging(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        child: state is! LoginLoadingState
                            ? Text(
                          'LOGIN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                            : CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                               overlayColor: Colors.blue,
                            ),
                            onPressed: () {
                              navigateTo(context, SignUpScreen());
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
      }),
    );
  }
}