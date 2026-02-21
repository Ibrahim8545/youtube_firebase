import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:youtubefirebase/core/share_pres.dart';
import 'package:youtubefirebase/features/auth/screens/home_screen.dart';
import 'package:youtubefirebase/features/auth/screens/screen_login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = CacheHelper.isLoggedIn();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const HomeScreen() : LoginScreen(),
    );
  }
}
