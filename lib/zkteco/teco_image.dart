import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'finger_status.dart';
import 'finger_status_type.dart';

class TecoApp{
  String sendUrl = 'https://google.com/';
  String base64Image = 'base64isNotGenerated';

  String? score;
  String? message;
  Map<String, String> users = {};
  Uint8List? fingerImages;
  String statusText = '';
  String stringLengthBytes = '';

  FingerStatus? fingerStatus;
  FingerStatusType? tempStatusType;
  bool? isDeviceSupported;

  Widget _getFingerStatusImage() {
    if (fingerStatus == null) {
      return SvgPicture.asset(
        'assets/finger.svg',
        color: Colors.black38,
        width: 70,
        height: 120,
      );
    }
    Color svgColor = Colors.black12;
    switch (fingerStatus!.statusType) {
      case FingerStatusType.FINGER_EXTRACTED:
      case FingerStatusType.STARTED_ALREADY:
      case FingerStatusType.STARTED_SUCCESS:
        svgColor = Colors.indigo;
        break;
      case FingerStatusType.VERIFIED_SUCCESS:
        svgColor = Colors.green;
        break;
      case FingerStatusType.VERIFIED_FAILED:
        svgColor = Colors.redAccent;
        break;
      case FingerStatusType.VERIFIED_ERROR:
        svgColor = Colors.red;
        break;
      case FingerStatusType.IDENTIFIED_START_FIRST:
      case FingerStatusType.IDENTIFIED_FAILED:
        svgColor = Colors.redAccent;
        break;
      case FingerStatusType.IDENTIFIED_SUCCESS:
        svgColor = Colors.blue;
        break;
      case FingerStatusType.ENROLL_ALREADY_EXIST:
      case FingerStatusType.ENROLL_CONFIRM:
      case FingerStatusType.ENROLL_STARTED:
      case FingerStatusType.ENROLL_SUCCESS:
        svgColor = Colors.green;
        break;
      case FingerStatusType.STOPPED_ALREADY:
      case FingerStatusType.STOPPED_SUCCESS:
        svgColor = Colors.red;
        break;
      case FingerStatusType.FINGER_CLEARED:
        svgColor = Colors.yellow;
        break;
      case FingerStatusType.STARTED_FAILED:
        svgColor = Colors.redAccent;
        break;
      case FingerStatusType.STARTED_ERROR:
        svgColor = Colors.red;
        break;
      case FingerStatusType.ENROLL_FAILED:
        svgColor = Colors.redAccent;
        break;
      case FingerStatusType.STOPPED_ERROR:
        svgColor = Colors.red;
        break;
      case FingerStatusType.CAPTURE_ERROR:
        svgColor = Colors.red;
        break;
      default:
        svgColor = Colors.black38;
    }

    return SvgPicture.asset(
      'assets/finger.svg',
      color: svgColor,
      width: 70,
      height: 120,
    );

  }
}