import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:projects/model/participant.dart';
import 'package:projects/model/schedule_meeting.dart';


// import 'homepage.dart';
import 'login/login.dart';
import 'login/meeting.dart';
import 'login/sign_up.dart';

void main() {
  Hive.initFlutter();
  Hive.registerAdapter(ScheduleMeetingAdapter());
  Hive.registerAdapter(ParticipantAdapter());
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
