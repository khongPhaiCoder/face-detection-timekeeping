import 'package:flutter/material.dart';
import 'package:my_project/Screens/Login/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterDemo',
      theme: ThemeData(),
      home: const LoginPage(),
    );
  }
}
