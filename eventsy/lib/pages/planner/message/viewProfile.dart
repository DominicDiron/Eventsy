import 'dart:async';
import 'package:eventsy/model/Planner/currentId.dart';
import 'package:eventsy/model/Planner/currentPlanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import '../search/search.dart';
//import 'package:http/http.dart' as http;

CurrentId currentuser = CurrentId();
int currentUserId = currentuser.currentUserId;

class User extends StatelessWidget {
  final List person;
  final int index;
  const User({Key? key, required this.person, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          header(),
          const SizedBox(height: 15.0),
          contact()
        ],
      ),
    );
  }

  Widget header() {
      // Only access userData if it's not empty
      return Container(
        color: const Color.fromARGB(255, 18, 140, 126),
        width: double.infinity,
        height: 200,
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                margin: const EdgeInsets.only(bottom: 15.0),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3.0),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(person[index]['profileIMG']),
                  ),
                ),
              ),
              onTap: () { },
            ),
            Text(
              person[index]['name'],
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              person[index]['email'],
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      );
  }

  Widget contact() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Contact",
                  style: TextStyle(
                      color: Color.fromARGB(255, 18, 140, 126),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                    icon: const Icon(
                      Icons.mail,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      String mail = "mailto:${person[index]['email']}";
                      final Uri url = Uri.parse(mail);
                      launchUrl(url);
                    }),
                IconButton(
                    icon: const Icon(Icons.chat,color: Colors.green,),
                    onPressed: () {
                      String whatsapp =
                          "https://wa.me/${person[index]['contact']}?text=Hi this message is through Eventsy as planner";
                      final Uri url = Uri.parse(whatsapp);
                      launchUrl(url);
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

}
