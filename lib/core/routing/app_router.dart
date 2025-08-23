
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fakebook/core/routing/routes.dart';
import 'package:fakebook/features/home/home_screen.dart';
import 'package:fakebook/features/login/presentation/login_screen.dart';
import 'package:fakebook/features/splash/splash_screen.dart';
import '../../features/home/cubit/cubit.dart';
import '../../features/register/cubit/register_cubit.dart';
import '../../features/register/register_screen.dart';

final router = GoRouter(
  initialLocation: Routes.login,
  routes: [

    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: Routes.register,
      builder: (context, state) => BlocProvider(
        create: (_) => RegisterCubit(),
        child: RegisterScreen(),
      ),
    ),

    GoRoute(
      path: Routes.login,
      builder: (context, state) => LoginScreen(),
    ),

    GoRoute(
      path: Routes.home,
      builder: (context, state) => BlocProvider(
        create: (_) => HomeCubit(),
        child: HomeScreen(),
      ),
    ),
  ],
);
