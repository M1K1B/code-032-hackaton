import 'package:flutter/material.dart';
import 'package:hackaton/screens/home_screen.dart';
import 'package:hackaton/screens/login_screen.dart';
import 'package:hackaton/screens/my_profile_screen.dart';
import 'package:hackaton/screens/new_post_screen.dart';
import 'package:hackaton/screens/post_details_screen.dart';
import 'package:hackaton/screens/register_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackaton/services/global_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SoS - Studenti Studentima',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return HomeScreen();
            else
              return LoginScreen();
          },
        ),
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          NewPostScreen.routeName: (context) => const NewPostScreen(),
          MyProfileScreen.routeName: (context) => const MyProfileScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
        });
  }
}
