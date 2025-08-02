import 'package:fakebook/core/routing/routes.dart';
import 'package:fakebook/features/login/cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/home_screen.dart';
import '../../features/login/login_screen.dart';
import '../../features/sign_up/register.dart';
import '../../features/splash/splash_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: Routes.splash, builder: (context, state) => const SplashScreen()),
    GoRoute(
        path: Routes.register, builder: (context, state) => RegisterScreen()),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => BlocProvider(
        create: (_) => LoginCubit(),
        child: LoginScreen(),
      ),
    ),
    GoRoute(path: Routes.home, builder: (context, state) => const HomeScreen()),
  ],
);
