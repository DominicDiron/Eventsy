import 'dart:async';
import 'package:eventsy/pages/user/projects/canceled.dart';
import 'package:eventsy/pages/user/projects/completed.dart';
import 'package:eventsy/pages/user/projects/inProgress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 18, 140, 126),
          appBar: AppBar(
          title: const Text(
            'Bookings',
            style: TextStyle(fontFamily: 'Arial', color: Colors.white),
          ),
          bottom: const TabBar(
              tabs: [
                Tab(text: 'In Progress'),
                Tab(text: 'Completed',),
                Tab(text: 'Canceled'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
             InProgress(),
             Completed(),
             Canceled()
            ],
          ),
        ),
    );
  }
}
