import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ViewProfile extends StatefulWidget {
  final List person;
  
  const ViewProfile({Key? key, required this.person})
      : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState(person);
}

class _ViewProfileState extends State<ViewProfile> {
  List person;
  _ViewProfileState(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: const Color.fromARGB(255, 18, 140, 126),
          title: title(),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            carousel(),
            const Divider(height: 2, color: Colors.white),
            contact(),
            const Divider(height: 2, color: Colors.white),
            name(),
            const Divider(height: 2, color: Colors.white),
            about(),
            const Divider(height: 2, color: Colors.white),
            service(),
            const Divider(height: 2, color: Colors.white),
            const Divider(height: 2, color: Colors.white),
          ],
        ),
        );
  }

  Widget title() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      CircleAvatar(backgroundImage: NetworkImage(person[0]['profileIMG'])),
      const SizedBox(width: 20.0),
      SizedBox(
        child: Text(
          person[0]['name'], // index - 1 is name
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ]);
  }


  Widget carousel() {
    List<String> imageList = [
      person[0]['image1'],
      person[0]['image2'],
      person[0]['image3'],
      person[0]['image4'],
      // Add more image URLs or local asset paths as needed
    ];

    return SingleChildScrollView(
      child: SizedBox(
          height: 250,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200, // Set the desired height of the carousel
              autoPlay: true, // Enable auto-play
              aspectRatio: 16 / 9, // Adjust the aspect ratio of the images
              enlargeCenterPage: true, // Make the center image larger
              // You can configure more options as per your requirements
            ),
            items: imageList.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          )),
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
                      String mail = "mailto:${person[0]['email']}";
                      final Uri url = Uri.parse(mail);
                      launchUrl(url);
                    }),
                IconButton(
                    icon: const Icon(Icons.chat,color: Colors.green,),
                    onPressed: () {
                      String whatsapp =
                          "https://wa.me/${person[0]['contact']}?text=Hi this message is through Eventsy";
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

  Widget name() {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 90,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(person[0]['name'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                const Text('Professional Event Planner',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontStyle: FontStyle.italic)),
              ],
            ),
            //printRate(person[0]['rate']),
          ]),
    );
  }

  Widget printRate(int rate) {
    String stars = '';
    for (int i = 0; i < rate; i++) {
      stars += '⭐ ';
    }
    return SizedBox(
      child: Text(
        stars,
        style: const TextStyle(
            color: Colors.amber, fontSize: 23.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget about() {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                person[0]['description'],
                style: const TextStyle(color: Colors.white, fontSize: 15.0),
              )
            ]));
  }

  Widget service() {
    List serviceList;
    List<dynamic> services = person[0]['services'].split(',');
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Services By Planner',
          style: TextStyle(
              color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: services.length,
          itemBuilder: (context, i) {
            serviceList = services;
            return ListTile(
              leading: Text(
                serviceList[i],
                style: const TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            );
          },
        )),
      ]),
    );
  }

  // Widget friends() {
  //   List friendList;
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //       const Text(
  //         'Contributers with Planner',
  //         style: TextStyle(
  //             color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(
  //         height: 10.0,
  //       ),
  //       ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: person[0]['friends'].length,
  //         itemBuilder: (context, i) {
  //       friendList = person[0]['friends'];
  //       return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
  //         CircleAvatar(
  //             backgroundImage: NetworkImage(friendList[i]['profileIMG'])),
  //         const SizedBox(width: 20.0),
  //         SizedBox(
  //           child: Text(
  //             friendList[i]['name'], // index - 1 is name
  //             style: const TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //         )
  //       ]);
  //         },
  //       ),
  //     ]),
  //   );
  // }

  // Widget footer() {
  //   //String button = "Hire";
  //   if (person[0]['plannerID'] == currentuserid) {
  //     return const SizedBox(
  //       height: 0,
  //     );
  //   }
  //   return ElevatedButton(
  //       onPressed: () {
  //         //addFriend(person[0]['plannerID']);
  //       },
  //       style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
  //       child: const Text("Hire",
  //           style: TextStyle(fontSize: 20, color: Colors.black)));
  // }

}