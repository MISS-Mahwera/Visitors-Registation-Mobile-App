// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'homepage.dart';
//
// class Splash extends StatefulWidget {
//   const Splash({super.key});
//
//   @override
//   State<Splash> createState() => _SplashState();
// }
//
// class _SplashState extends State<Splash> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 8), () {
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => HomePage()));
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//
//      return Scaffold(
//        backgroundColor:
//        Colors.blue, // Set the background color to your desired color
//        body: Center(
//          child: Image.asset('assets/images.png',
//            width: 400,
//            height: 350,
//
//          //  FlatButton(onpressed: (){}, child:text("LOGIN"))
//          ),
//     // ignore: prefer_const_constructors
//       /* SizedBox(height: 20,
//        width: 30,), // Add a space between image and button
//     ElevatedButton(
//     onPressed: () {
//     // Navigate to the next screen
//     Navigator.pushNamed(context, 'login');
//     },
//     child: const Text('Get Started'),
//     */
//        */
//        ),
//      ),
//      );
//   }
// }
//
//
//
