import 'package:flutter/material.dart';
import 'package:pokemon/UI/screens/splash.dart';
import 'package:pokemon/ui/screens/auth_screens/login.dart';
import 'package:pokemon/ui/screens/auth_screens/signup.dart';
import 'package:pokemon/ui/screens/favourite.dart';
import 'package:pokemon/ui/screens/home.dart';
import 'package:pokemon/utils/routes/route_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Splash Screen
      case RouteNames.splashScreenRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );
    //Splash Screen
      case RouteNames.signUpScreenRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SignupScreen(),
        );

      case RouteNames.loginScreenRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        );
      case RouteNames.homeRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );
      case RouteNames.favouriteRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const FavouriteScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No route defined'),
              ),
            );
          },
        );
    }
  }
}
