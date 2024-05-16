import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ViewProject extends StatefulWidget {
  final List person;

  const ViewProject({Key? key, required this.person})
      : super(key: key);

  @override
  State<ViewProject> createState() => _ViewProjectState(person);
}

class _ViewProjectState extends State<ViewProject> {
  List person;
  _ViewProjectState(this.person);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
        appBar: AppBar(
          title: Text(
            person[0]['name'],
            style: TextStyle(fontFamily: 'Arial', color: Colors.white),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                contact(),
                const SizedBox(height: 10.0),
                Confrimation(),
              ],
            )));
  }

  Widget contact() {
    print(person[0]['userbookingID']);
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
            'Contact Details',
          style: TextStyle(
              color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
            Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.chat,color: Colors.green,),
                    onPressed: () {
                      String whatsapp =
                          "https://wa.me/${person[0]['contact']}?text=Hi this message is through Eventsy";
                      final Uri url = Uri.parse(whatsapp);
                      launchUrl(url);
                    }),
                const SizedBox(width: 15.0,),
                Text(person[0]['contact'],style: const TextStyle(
              color: Colors.white, fontSize: 15,  letterSpacing: 1.5))
              ],
            ),
            Row(
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.mail,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      String mail = "mailto:${person[0]['email']}";
                      final Uri url = Uri.parse(mail);
                      launchUrl(url);
                    }),
                const SizedBox(width: 15.0,),
                Text(person[0]['email'],style: const TextStyle(
              color: Colors.white, fontSize: 15, letterSpacing: 1.5))
              ],
            )
          ],
        ),
    );
  }

Widget Confrimation() {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
            'Vender Confirmation',
          style: TextStyle(
              color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        action(person[0]['userbookingID']),
          ],
        ),
    );
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
                                'Are you sure you want to cancel this project?'),
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
        SizedBox(
          height: 30,
          width: 120,
          child: ElevatedButton(
            onPressed: () async {
             showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Completed?'),
                            content: const Text(
                                'Are you sure you completed this project?'),
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
                                  bool result = await completed(userbookingID);
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
                backgroundColor: Color.fromARGB(255, 18, 140, 126),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: const Text(
              'Completed',
              style: TextStyle(
                  fontSize: 15,
                  //letterSpacing: 2,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        
      ],
    );
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

Future<bool> completed(int userbookingID) async {
  final url = 'http://127.0.0.1:8000/api/completeUserBooking/$userbookingID';
  //final url = 'https://dreamy-wilson.34-81-183-3.plesk.page/api/completeUserBooking/$userbookingID';
  try {
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      print("completed");
      return true;
    } else {
      String msg = 'Error on complteting';
      print(response.statusCode);
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

}