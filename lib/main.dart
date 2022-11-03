import 'package:flutter/material.dart';
import 'package:ncc/appscreens/checkin.dart';
import 'package:ncc/login/login.dart';
import 'package:ncc/login/sign_up.dart';
import 'package:ncc/start_screen.dart';
import 'package:ncc/appscreens/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: StartScreen.id,
      routes: {
        StartScreen.id: (context) => StartScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        LandingPage.id: (context) => LandingPage(),
        CheckinScreen.id: (context) => CheckinScreen(),
      },
    );
  }
}
