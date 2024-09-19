import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:projects/model/schedule_meeting.dart';

import '../model/participant.dart';
// 'model/participant.dart';
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}


class _homepageState extends State<homepage> {
  final _formKey = GlobalKey<FormState>();
  String _companyName = '';
  String _region = '';
  DateTime _meetingDate = DateTime.now();
  int _daysTaken = 1;

  // Declare the Hive box variable
  Box<ScheduleMeeting>? mySchedule;

  // List to store Participant details
  List<Participant> _participants = [];

  @override
  void initState() {
    super.initState();
    // Open the Hive box in initState
    _openBox();
  }

  // Method to open the Hive box
  Future<void> _openBox() async {
    mySchedule = await Hive.openBox<ScheduleMeeting>('my_schedule');
  }

  // Method to select date
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

  // Method to add a new participant
  void _addParticipant() {
    setState(() {
      _participants.add(Participant(name: "", phoneNumber: ""));
    });
  }

  // Method to remove a participant
  void _removeParticipant(int index) {
    setState(() {
      _participants.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
       // title: Text("Schedule Meeting"),
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
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
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
                      decoration: InputDecoration(
                          labelText: 'Days Taken for Meeting'),
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
                    // Participants Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Participants",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                                  decoration: InputDecoration(
                                      labelText: 'Participant Name'),
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
                                  decoration: InputDecoration(
                                      labelText: 'Phone Number'),
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

                          // Create the Schedule object
                          ScheduleMeeting schedule = ScheduleMeeting(
                            name: _companyName,
                            region: _region,
                            date: _meetingDate,
                            days: _daysTaken,
                            participant: _participants,
                          );

                          // Ensure that the Hive box is opened
                          await mySchedule?.put(schedule.id, schedule);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Registration Successful!')),
                          );

                          // Handle form submission here
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


