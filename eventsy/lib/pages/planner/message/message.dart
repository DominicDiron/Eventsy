import 'package:eventsy/model/Planner/projects.dart';
import 'package:eventsy/pages/planner/message/viewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {

  Projects bookings = Projects();
  List requests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
        appBar: AppBar(
          title: const Text(
            'Alerts',
            style: TextStyle(fontFamily: 'Arial', color: Colors.white),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                title(),
                const SizedBox(height: 10.0),
                request(),
              ],
            )));
  }

  Widget title() {
    return Card(
      semanticContainer: true,
      borderOnForeground: true,
      shadowColor: const Color.fromARGB(255, 18, 140, 126),
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Requests',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Color.fromARGB(255, 18, 140, 126)),
          )
        ],
      ),
    );
  }

  Widget request() {
    return Expanded(
      child: FutureBuilder<List>(
          future: bookings.getBookRequests(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              requests = snapshot.data!;
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: requests.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      child: Card(
                        color: Colors.black87,
                        child: Row(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Image.network(
                                requests[i]['profileIMG'],
                                fit: BoxFit.fill)),
                            //const SizedBox(width: 10.0),
                            Flexible(
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  printName(requests[i]['name']),
                                  const Text('User', style: TextStyle(color: Colors.white,fontSize: 15.0,fontStyle: FontStyle.italic)),
                                  printEmail(requests[i]['email']),
                                  printPlace(requests[i]['location']),
                                  action(requests[i]['userbookingID'])
                                ],
                              ))
                        ]),
                      ),
                      onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => User(person: requests, index: i)));
                          },
                    );
                  });
            } else {
              return const Center(
                child: CupertinoActivityIndicator(
                  radius: 15.0,
                  color: Color.fromARGB(255, 18, 140, 126),
                ),
              );
            }
          })),
    );
  }

  Widget printName(String name) {
    return Text(name,
        style: const TextStyle(
            color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.bold));
  }

  Widget printEmail(String email) {
    return Text(email,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.normal));
  }

  Widget printPlace(String place) {
    return Text(place,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.normal));
  }

  Widget action(int userbookingID)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 30,
          width: 120,
          child: ElevatedButton(
            onPressed: () async {
             showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Cancel?'),
                            content: const Text(
                                'Are you sure you want to cancel this request?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Close the dialog and navigate back without saving
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  bool result = await cancel(userbookingID);
                                  if (result) {
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: const Text(
              'Cancel',
              style: TextStyle(
                  fontSize: 15,
                  //letterSpacing: 2,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        //const SizedBox(width: 10.0),
        SizedBox(
          height: 30,
          width: 120,
          child: ElevatedButton(
            onPressed: () async {
              bool result = await accept(userbookingID);
              if (result) {
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 18, 140, 126),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: const Text(
              'Accept',
              style: TextStyle(
                  fontSize: 15,
                  //letterSpacing: 2,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                  ),
            ),
          ),
        )
      ],
    );
  }


  Future<bool> accept(int userbookingID,) async {
  final url = 'http://127.0.0.1:8000/api/acceptUserRequest/$userbookingID';
  //final url = 'https://dreamy-wilson.34-81-183-3.plesk.page/api/acceptUserRequest/$userbookingID';

  try {
    final response = await http.post(Uri.parse(url)
    );

    if (response.statusCode == 200) {
      String msg = 'Request updated';
      print(msg);
      return true;
    } else {
      String msg = 'Error updating request';
      print(response.statusCode);
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

  Future<bool> cancel(int userbookingID) async {
  final url = 'http://127.0.0.1:8000/api/cancelUserRequest/$userbookingID';
  //final url = 'https://dreamy-wilson.34-81-183-3.plesk.page/api/cancelUserRequest/$userbookingID';
  try {
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Cancelled");
      return true;
    } else {
      String msg = 'Error on deleting';
      print(response.statusCode);
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

}
