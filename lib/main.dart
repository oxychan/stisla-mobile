import 'package:flutter/material.dart';
import 'package:stisla/page/dashboard.dart';
import 'package:stisla/page/detail_category.dart';
import 'package:stisla/page/login.dart';
import 'package:stisla/page/register.dart';
import 'package:stisla/page/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway',
      ),
      initialRoute: '/splash',
      routes: {
        '/': (context) => const Dashboard(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/splash': (context) => const SplashScreen(),
        '/detail-category': (context) => const DetailCategory(),
      },
    );
  }
}
