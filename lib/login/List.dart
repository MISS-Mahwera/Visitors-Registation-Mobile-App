import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CompanyFormPage extends StatefulWidget {
  @override
  _CompanyFormPageState createState() => _CompanyFormPageState();
}

class _CompanyFormPageState extends State<CompanyFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _companyName = '';
  String _region = '';
  DateTime _meetingDate = DateTime.now();
  int _days = 0;
  List<Attendance> _attendanceList = [];

  void _addAttendanceField() {
    setState(() {
      _attendanceList.add(Attendance(name: '', phoneNumber: ''));
    });
  }

  void _removeAttendanceField(int index) {
    setState(() {
      _attendanceList.removeAt(index);
    });
  }

  Future<void> _selectMeetingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _meetingDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _meetingDate) {
      setState(() {
        _meetingDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Registration'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Meeting Date: ${DateFormat.yMd().format(_meetingDate)}',
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectMeetingDate(context),
                    child: Text('Select Date'),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Days Taken on Meeting'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the number of days';
                  } else if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _days = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              Text(
                'Attendance',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _attendanceList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _attendanceList[index].name = value!;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Phone Number'),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a phone number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _attendanceList[index].phoneNumber = value!;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            _removeAttendanceField(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addAttendanceField,
                child: Text('Add Attendee'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registration Successful!')),
                    );
                    // Add your form submission logic here
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Attendance {
  String name;
  String phoneNumber;

  Attendance({required this.name, required this.phoneNumber});
}
