import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projects/homepage.dart';

void main() {
  runApp(MeetingApp());
}

class MeetingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MeetingListPage(),
    homepage(),
    // AddMeetingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Meetings',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.add),
          //   label: 'Add Meeting',
          // ),
        ],
      ),
    );
  }
}


class AddMeetingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Add New Meeting'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text(
          'Add New Meeting Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class Meeting {
  final String name;
  final DateTime date;
  final List<String> participants;

  Meeting({required this.name, required this.date, required this.participants});
}
class Participant {

}

class MeetingListPage extends StatefulWidget {
  @override
  _MeetingListPageState createState() => _MeetingListPageState();
}

class _MeetingListPageState extends State<MeetingListPage> {
  List<Meeting> meetings = [
    Meeting(
      name: "Team Sync",
      date: DateTime.now().subtract(Duration(days: 1)),
      participants: ["Alice", "Bob", "Charlie"],
    ),
    Meeting(
      name: "Client Meeting",
      date: DateTime.now(),
      participants: ["David", "Eve", "Frank"],
    ),
    Meeting(
      name: "Project Kickoff",
      date: DateTime.now().add(Duration(days: 3)),
      participants: ["George", "Hannah", "Isaac"],
    ),
    Meeting(
      name: "Planning Meeting",
      date: DateTime.now().add(Duration(days: 8)),
      participants: ["Jack", "Karen", "Liam"],
    ),
    Meeting(
      name: "Retrospective",
      date: DateTime.now().subtract(Duration(days: 7)),
      participants: ["Mia", "Noah", "Olivia"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime nextWeek = today.add(Duration(days: 7));

    List<Meeting> ongoingMeetings = meetings.where((meeting) {
      return meeting.date.day == today.day &&
          meeting.date.month == today.month &&
          meeting.date.year == today.year;
    }).toList();

    List<Meeting> outdatedMeetings = meetings.where((meeting) {
      return meeting.date.isBefore(today);
    }).toList();

    List<Meeting> nextWeekMeetings = meetings.where((meeting) {
      return meeting.date.isAfter(today) && meeting.date.isBefore(nextWeek);
    }).toList();
    List<Meeting> pendingMeetings = meetings.where((meeting) {
      return meeting.date.isAfter(today);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Meetings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildExpandableSection('Ongoing Meetings', Icons.play_circle_fill, ongoingMeetings),
              SizedBox(height: 24),
              buildExpandableSection('Next week Meetings', Icons.calendar_today, nextWeekMeetings),
              SizedBox(height: 24),
              buildExpandableSection('Pending Meetings', Icons.pending_actions, pendingMeetings),
              SizedBox(height: 24),
              buildExpandableSection('Outdated Meetings', Icons.history, outdatedMeetings),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildExpandableSection(String title, IconData icon, List<Meeting> meetings) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.blueAccent, size: 30),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
      children: [
        if (meetings.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('No meetings in this category', style: TextStyle(color: Colors.grey)),
          )
        else
          ...meetings.map((meeting) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(meeting.name, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMMd().format(meeting.date)),
                    SizedBox(height: 8),
                    Text("Participants:"),
                    for (var participant in meeting.participants)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(participant, style: TextStyle(color: Colors.blueGrey)),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
      ],
    );
  }
}
