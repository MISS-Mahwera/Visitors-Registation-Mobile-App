import 'package:flutter/material.dart';
import 'package:projects/splash.dart';

import 'homepage.dart';
import 'login/List.dart';
import 'login/login.dart';
import 'login/meeting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // title: 'GLOBAL PROGRAM VISITORS ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),

    );

  }
}
