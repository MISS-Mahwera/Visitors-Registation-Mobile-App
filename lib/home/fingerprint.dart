import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FingerprintService {
  static const platform = MethodChannel('com.example.attendance/fingerprint');

  static Future<String> captureFingerprint() async {
    try {
      final String result = await platform.invokeMethod('captureFingerprint');
      return result; // This should return the fingerprint data
    } on PlatformException catch (e) {
      return "Failed to capture fingerprint: '${e.message}'.";
    }
  }
}


class FingerprintCaptureScreen extends StatefulWidget {
  @override
  _FingerprintCaptureScreenState createState() => _FingerprintCaptureScreenState();
}

class _FingerprintCaptureScreenState extends State<FingerprintCaptureScreen> {
  bool _isCapturing = false;
  String _captureStatus = '';

  Future<void> _captureFingerprint() async {
    setState(() {
      _isCapturing = true;
      _captureStatus = '';
    });

    final String result = await FingerprintService.captureFingerprint();

    setState(() {
      _isCapturing = false;
      _captureStatus = result.contains("Failed") ? "Capture Failed" : "Capture Successful: $result";
    });

    Fluttertoast.showToast(msg: _captureStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ZKTeco Fingerprint Capture')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _captureFingerprint,
              child: _isCapturing ? CircularProgressIndicator() : Text('Capture Fingerprint'),
            ),
            SizedBox(height: 20),
            Text(_captureStatus),
          ],
        ),
      ),
    );
  }
}
