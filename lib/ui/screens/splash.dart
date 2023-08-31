

import 'package:flutter/material.dart';
import 'package:pokemon/utils/constants/constants.dart';
import 'package:pokemon/utils/constants/image_path.dart';
import 'package:pokemon/utils/pref_utils/prefs_keys.dart';
import 'package:pokemon/utils/pref_utils/shared_prefs.dart';
import 'package:pokemon/utils/routes/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    navigateConditionally();
    super.initState();
  }

  void navigateConditionally() async {
    SharedPreferences pref = await Prefs.instance;

      bool rememberMe = await _getRememberMe(pref);
      await Future.delayed(const Duration(seconds: 2)).whenComplete(
            () => Navigator.pushReplacementNamed(
            context,
            rememberMe
                ? RouteNames.homeRoute
                : RouteNames.loginScreenRoute),
      );
  }

  Future<bool> _getRememberMe(SharedPreferences pref) async {
    if (pref.containsKey(UserInfoKeys.oneTimeLogin)) {
      return pref.getBool(UserInfoKeys.oneTimeLogin)!;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: screenWidth(context, 1),
        height: screenHeight(context, 1),
        decoration: const BoxDecoration(color: defaultColor),
        child: Center(
          child: Image.asset(
            ImagePath.appLogo,
            width: screenWidth(context, 0.9),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}