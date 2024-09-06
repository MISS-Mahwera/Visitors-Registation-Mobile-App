// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
//
// import '../homepage.dart';
// import '../login/meeting.dart';
//
// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({super.key});
//
//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }
//
// class _BottomNavigationState extends State<BottomNavigation> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _pages = [
//     VisitorRegistrationPage(),  // Home
//     SearchPage(),       // Search
//     LikePage(),         // Like
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         elevation: 20,
//         title: const Text('GoogleNavBar'),
//       ),
//       body: Center(
//         child: _pages.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: Container(
//         color: Colors.blueAccent,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//           child: GNav(
//             gap: 8,
//             color: Colors.white,
//             activeColor: Colors.white,
//             iconSize: 24,
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             duration: Duration(milliseconds: 400),
//             tabBackgroundColor: Colors.black.withOpacity(0.2),
//             tabs: const [
//               GButton(
//                 icon: Icons.home,
//                 text: 'Home',
//               ),
//               GButton(
//                 icon: Icons.search,
//                 text: 'Search',
//               ),
//               GButton(
//                 icon: Icons.favorite,
//                 text: 'Like',
//               ),
//             ],
//             selectedIndex: _selectedIndex,
//             onTabChange: (index) {
//               setState(() {
//                 _selectedIndex = index;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
