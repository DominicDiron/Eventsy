import 'package:eventsy/pages/user/message/message.dart';
import 'package:eventsy/pages/user/profile/profile.dart';
import 'package:eventsy/pages/user/projects/booking.dart';
import 'package:eventsy/pages/user/search/search.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  
  int _activePageIndex = 0;
  final List<Widget> _pages = [const Search(),const Message(),const Booking(),const Profile()]; // if you want add any field to this

  void onTapped(int index) {
    setState(() {
      _activePageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Color.fromARGB(255, 18, 140, 126)),
      ),
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        bottomNavigationBar: CurvedNavigationBar(
          index: _activePageIndex,
          backgroundColor: Colors.blueGrey.shade900,
          color: const Color.fromARGB(255, 18, 140, 126),
          //animationCurve: Curves.easeOut,
          items:
          const <Widget>[
            Icon(Icons.search),
            Icon(Icons.message),
            Icon(Icons.book),
            Icon(Icons.person),
          ],
          onTap: onTapped,
        ),
        body: _pages[_activePageIndex],
      ),
    );
  }

  // List<Widget> user(){
  //   if(userLogedin)
  //   {
  //     return const <Widget>[
  //           Icon(Icons.search),
  //           Icon(Icons.message),
  //           Icon(Icons.book),
  //           Icon(Icons.person),
  //         ];
  //   }
  //   else
  //   {
  //     final List<Widget> _pages = [const Search()];
  //     return const <Widget>[
  //           Icon(Icons.search)];
  //   }

  // }
}