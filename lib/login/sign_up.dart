import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'login.dart';
import 'meeting.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isBiometricSupported = false;
  bool _isBiometricEnrolled = false;
  String? _biometricToken;
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  String _Region = '';

  Box? userBox;
  @override
  void initState() {
    super.initState();
    _openHiveBox();
  }

  Future<void> _openHiveBox() async {
    userBox = await Hive.openBox('userBox'); // Open the Hive box for user data
  }

  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isFingerprintRegistered = false;
  String _fingerprintStatus = 'Not registered';

  Future<void> _checkBiometricSupport() async {
    bool isSupported = await auth.isDeviceSupported();
    bool hasBiometric = await auth.canCheckBiometrics;

    setState(() {
      _isBiometricSupported = isSupported;
      _isBiometricEnrolled = hasBiometric;
    });
  }

  // Method to handle biometric registration
  Future<void> _registerBiometric() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate with fingerprint',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        // Generate a secure token (for example, a hash) that will be sent to the backend
        String rawData = "user_fingerprint_" + DateTime.now().toIso8601String();
        String generatedToken = sha256.convert(utf8.encode(rawData)).toString();
        print(generatedToken);

        setState(() {
          _biometricToken = generatedToken;
        });
      }
    } catch (e) {
      // Handle error
      print('Error during biometric authentication: $e');
    }

    // t
  }

  Future<void> _saveUserData() async {
    if (userBox != null) {
      userBox!.put('name', _name);
      userBox!.put('email', _email);
      userBox!.put('password', _password); // Consider hashing passwords
      userBox!.put('region', _Region);
      userBox!.put('biometricToken', _biometricToken);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Name Input
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.person),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 9),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value!;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Email Input
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password Input
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 9),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Region Input
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Region',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.location_on),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 9),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Region';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _Region = value!;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Fingerprint Registration Button
                      ElevatedButton(
                        onPressed: _registerBiometric,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text("Register Fingerprint"),
                      ),

                      const SizedBox(height: 16),

                      // Fingerprint Status Display
                      _isFingerprintRegistered
                          ? Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: const Icon(
                          Icons.fingerprint,
                          size: 60,
                          color: Colors.black,
                        ),
                      )
                          : Text(
                        _fingerprintStatus,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Sign Up Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Sign Up Successful!')),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MeetingApp(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text("Sign Up"),
                      ),
                      const SizedBox(height: 16),

                      // Already have an account? Login button
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Already have an account? Login",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

);
}
}


