import 'package:eventsy/model/Planner/favourite.dart';
import 'package:eventsy/pages/planner/search/viewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Contributors extends StatefulWidget {
  const Contributors({super.key});

  @override
  State<Contributors> createState() => _ContributorsState();
}

class _ContributorsState extends State<Contributors> {
  PlannerFavourites friends = PlannerFavourites();
  List confirmed = [];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
        appBar: AppBar(
          title: const Text(
            'Contributors',
            style: TextStyle(fontFamily: 'Arial', color: Colors.white),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                title(),
                const SizedBox(height: 10.0),
                contributors(),
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
            'Contributors',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Color.fromARGB(255, 18, 140, 126)),
          )
        ],
      ),
    );
  }

  Widget contributors() {
    return Expanded(
      child: FutureBuilder<List>(
          future: friends.getFriends(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              confirmed = snapshot.data!;
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: confirmed.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      child: Card(
                        color: Colors.black87,
                        child: Row(children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.16,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Image.network(confirmed[i]['profileIMG'],
                                  fit: BoxFit.fill)),
                          const SizedBox(width: 15.0),
                          Flexible(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              printName(confirmed[i]['name']),
                              const Text('Event Planner',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontStyle: FontStyle.italic)),
                              printEmail(confirmed[i]['email']),
                              printPlace(confirmed[i]['location']),
                              unfriend(confirmed[i]['contact'],confirmed[i]['friendID'])
                            ],
                          ))
                        ]),
                      ),
                      onTap: () {
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewProfile(list: confirmed, person: i)));
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

  Widget unfriend(String contact,int friendID) {
    return Padding(
      padding: const EdgeInsets.only(right:10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
                    icon: const Icon(Icons.chat,color: Color.fromARGB(255, 18, 140, 126)),
                    onPressed: () {
                      String whatsapp =
                          "https://wa.me/$contact?text=Hi this message is through Eventsy";
                      final Uri url = Uri.parse(whatsapp);
                      launchUrl(url);
                    }),
          SizedBox(
            height: 30,
            width: 120,
            child: ElevatedButton(
              onPressed: () async {
                showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Unfriend?'),
                            content: const Text(
                                'Are you sure you want to unfriend?'),
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
                                  bool result = await delete(friendID);
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
                'Unfriend',
                style: TextStyle(
                    fontSize: 15,
                    //letterSpacing: 2,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
         ],
      ),
    );
  }

  Future<bool> delete(int friendID,) async {
  print(friendID);
  final url = 'http://127.0.0.1:8000/api/deleteFriend/$friendID';
  //final url = 'https://dreamy-wilson.34-81-183-3.plesk.page/api/deleteFriend/$friendID';

  try {
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Friend deleted");
      return true;
    } else {
      String msg = 'Error on deleting friend';
      print(response.statusCode);
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

}
