import 'package:eventsy/model/Planner/favourite.dart';
import 'package:eventsy/pages/planner/search/viewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  PlannerFavourites favourites = PlannerFavourites();
  List plannerFavourites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
        appBar: AppBar(
          title: const Text(
            'Favourites',
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
            'Favourites',
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
          future: favourites.getFavourites(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              plannerFavourites = snapshot.data!;
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: plannerFavourites.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      child: Card(
                        color: Colors.black87,
                        child: Row(children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.16,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Image.network(plannerFavourites[i]['profileIMG'],
                                  fit: BoxFit.fill)),
                          const SizedBox(width: 15.0),
                          Flexible(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  printName(plannerFavourites[i]['name']),
                                  IconButton(
                                    icon: const Icon(Icons.favorite),
                                    color: Colors.red,
                                    onPressed: (){
                                      delete(plannerFavourites[i]['favouriteID']);
                                    })
                                ],
                              ),
                              const Text('Event Planner',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontStyle: FontStyle.italic)),
                              printEmail(plannerFavourites[i]['email']),
                              printPlace(plannerFavourites[i]['location']),
                              contact(plannerFavourites[i]['contact'],
                                  plannerFavourites[i]['email'])
                            ],
                          ))
                        ]),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                   ViewProfile(list: plannerFavourites, person: i)));
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

  Widget contact(String contact, String emailAddress) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: const Icon(Icons.chat,
                  color: Color.fromARGB(255, 18, 140, 126)),
              onPressed: () {
                String whatsapp =
                    "https://wa.me/$contact?text=Hi this message is through Eventsy";
                final Uri url = Uri.parse(whatsapp);
                launchUrl(url);
              }),
          IconButton(
                    icon: const Icon(
                      Icons.mail,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      String mail = "mailto:$emailAddress";
                      final Uri url = Uri.parse(mail);
                      launchUrl(url);
                    }),
        ],
      ),
    );
  }

  Future<bool> delete(int favouriteID) async {
    print(favouriteID);
    final url = 'http://127.0.0.1:8000/api/deleteFavourite/$favouriteID';
    //final url = 'https://dreamy-wilson.34-81-183-3.plesk.page/api/deleteFavourite/$favouriteID';

    try {
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        print("Favourite deleted");
        return true;
      } else {
        String msg = 'Error on deleting favourite';
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
