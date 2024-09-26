import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/participant.dart';
import '../model/schedule_meeting.dart';

class FingerprintService {
  static const platform = MethodChannel('com.example.attendance/fingerprint');

  static Future<String> captureFingerprint() async {
    try {
      final String result = await platform.invokeMethod('captureFingerprint');
      return result; // This should be the fingerprint data
    } on PlatformException catch (e) {
      return "Failed to capture fingerprint: '${e.message}'."; // Handle errors
    }
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  String _companyName = '';
  String _region = '';
  DateTime _meetingDate = DateTime.now();
  int _daysTaken = 1;
  Box<ScheduleMeeting>? mySchedule;

  List<Participant> _participants = [];
  bool _isCapturingFingerprint = false;
  String _captureStatus = ''; // To hold the status of the capture

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> checkUSBConnection() async {
    List<UsbDevice> devices = await UsbSerial.listDevices();

    if (devices.isNotEmpty) {
      Fluttertoast.showToast(msg: 'USB device connected.');
    } else {
      Fluttertoast.showToast(msg: 'No devices connected.');
    }
  }

  Future<void> _openBox() async {
    mySchedule = await Hive.openBox<ScheduleMeeting>('my_schedule');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _meetingDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _meetingDate) {
      setState(() {
        _meetingDate = picked;
      });
    }
  }

  void _addParticipant() {
    setState(() {
      _participants.add(Participant(name: "", phoneNumber: "", fingerprint: ""));
    });
  }

  void _removeParticipant(int index) {
    setState(() {
      _participants.removeAt(index);
    });
  }

  Future<void> _captureFingerprint(int index) async {
    bool? confirmCapture = await _showConfirmationDialog();

    if (confirmCapture == true) {
      setState(() {
        _isCapturingFingerprint = true; // Start loading
        _captureStatus = ''; // Reset status
      });

      final String result = await FingerprintService.captureFingerprint();

      setState(() {
        _isCapturingFingerprint = false; // Stop loading
        _participants[index].fingerprint = result; // Store captured fingerprint data
        _captureStatus = result.contains("Failed") ? "Capture Failed" : "Capture Successful";
      });
    }
  }

  Future<bool?> _showConfirmationDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Capture Fingerprint"),
          content: Text("Do you want to capture your fingerprint?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Capture"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Schedule Meeting"),
        actions: [
          IconButton(
            icon: Icon(Icons.usb),
            onPressed: checkUSBConnection,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'ADD NEW MEETING',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Company Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the company name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _companyName = value!;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Region'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the region';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _region = value!;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Meeting Date: ${DateFormat.yMd().format(_meetingDate)}',
                          ),
                        ),
                        TextButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Select Date'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Days Taken for Meeting'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the number of days taken';
                        } else if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _daysTaken = int.parse(value!);
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Participants",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: _addParticipant,
                          child: Text("Add Participant"),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _participants.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(labelText: 'Participant Name'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the name';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _participants[index].name = value!;
                                  },
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  decoration: InputDecoration(labelText: 'Phone Number'),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the phone number';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _participants[index].phoneNumber = value!;
                                  },
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () => _captureFingerprint(index),
                                  child: _isCapturingFingerprint
                                      ? CircularProgressIndicator()
                                      : Text('Capture Fingerprint'),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  _participants[index].fingerprint.isEmpty
                                      ? 'No fingerprint captured'
                                      : 'Fingerprint captured',

                                ),
                                Text(
                                  _captureStatus, // Display capture status
                                  style: TextStyle(
                                    color: _captureStatus.contains("Failed") ? Colors.red : Colors.green,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeParticipant(index),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          ScheduleMeeting schedule = ScheduleMeeting(
                            name: _companyName,
                            region: _region,
                            date: _meetingDate,
                            days: _daysTaken,
                            participant: _participants,
                          );

                          await mySchedule?.put(schedule.id, schedule);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Registration Successful!')),
                          );

                          print('Schedule: ${schedule.name}, ${schedule.region}, ${schedule.date}, ${schedule.days}, ${schedule.participant}');
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
