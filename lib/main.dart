import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon/UI/screens/splash.dart';
import 'package:pokemon/bloc/app_bloc.dart';
import 'package:pokemon/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // I have bound my user interface into portrait mode
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // Defining modes for the status bar and navigation bar in order to improve user experience
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: false,
      statusBarColor: Colors.transparent));
  // My Run Method
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child: const MaterialApp(
        title: 'Pokemon',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
