// import 'package:flutter/material.dart';
// import 'package:local_auth/local_auth.dart';
//
// class FingerprintLoginPage extends StatefulWidget {
//   @override
//   _FingerprintLoginPageState createState() => _FingerprintLoginPageState();
// }
//
// class _FingerprintLoginPageState extends State<FingerprintLoginPage> {
//   final LocalAuthentication _localAuth = LocalAuthentication();
//   bool _isAuthenticated = false;
//
//   // Authenticate using fingerprint
//   Future<void> _authenticate() async {
//     try {
//       bool authenticated = await _localAuth.authenticate(
//         localizedReason: 'Authenticate to sign in',
//         options: const AuthenticationOptions(
//           stickyAuth: true,
//           useErrorDialogs: true,
//         ),
//       );
//       setState(() {
//         _isAuthenticated = authenticated;
//       });
//     } catch (e) {
//       print("Error during authentication: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fingerprint Login'),
//       ),
//       body: Center(
//         child: _isAuthenticated
//             ? Text('Welcome! You are authenticated.',
//             style: TextStyle(fontSize: 24))
//             : Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Please authenticate with your fingerprint'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _authenticate,
//               child: Text('Authenticate'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
