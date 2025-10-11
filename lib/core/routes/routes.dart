import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/login/page/login_screen.dart';
import 'package:bookia/feature/auth/presentation/register/page/register_screen.dart';
import 'package:bookia/feature/home/page/home_screen.dart';
import 'package:bookia/feature/splash/splash_screen.dart';
import 'package:bookia/feature/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splashScreen = '/';
  static const String welcome = '/welcomeScreen';
  static const String login = '/login';
  static const String register = '/register';
  // static const String home = '/home';

  static GoRouter routes = GoRouter(
    routes: [
      GoRoute(path: splashScreen, builder: (context, state) => SplashScreen()),

      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),

      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(),
        ),
      ),
      // GoRoute(path: home, builder: (context, state) => HomeScreen()),
    ],
  );
}
