import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}


class _homepageState extends State<homepage> {
  final _formKey = GlobalKey<FormState>();
  String _CompanyName = '';
  String _Region = '';
  DateTime _meetingDate = DateTime.now();
  int _daysTaken = 1;

  // List to store attendance details
  List<Map<String, String>> _attendees = [];

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

  // Method to add a new attendee
  void _addAttendee() {
    setState(() {
      _attendees.add({"name": "", "phone": ""});
    });
  }

  // Method to remove an attendee
  void _removeAttendee(int index) {
    setState(() {
      _attendees.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
     //   title: Text("Visitor Registration"),
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
                      'Welcome Visitors',
                      style: TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
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
                        _CompanyName = value!;
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
                        _Region = value!;
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
                          labelText: 'Days Taken on Meeting'),
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
                    // Attendance Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Attendance",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: _addAttendee,
                          child: Text("Add Attendee"),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _attendees.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Attendee Name'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the name';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _attendees[index]['name'] = value!;
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
                                    _attendees[index]['phone'] = value!;
                                  },
                                ),
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeAttendee(index),
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Registration Successful!')),
                          );
                          // Handle form submission here
                          print('Company Name: $_CompanyName');
                          print('Region: $_Region');
                          print('Meeting Date: $_meetingDate');
                          print('Days Taken: $_daysTaken');
                          print('Attendees: $_attendees');
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
