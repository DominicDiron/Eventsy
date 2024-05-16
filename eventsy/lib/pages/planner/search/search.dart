import 'package:eventsy/model/Planner/currentId.dart';
import 'package:eventsy/model/Planner/planner.dart';
import 'package:eventsy/pages/planner/search/viewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Search extends StatefulWidget {
  const Search({super.key});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  Planners planners = Planners();
  List listCopy = [];

  List _foundPlanners = [];
  @override
  void initState() {
    _foundPlanners = listCopy;
    super.initState();
  }

  void _filterList(String keyword) {
    List results = [];
    if (keyword.isEmpty) {
      results = listCopy;
    } else {
      results = listCopy
          .where((planner) =>
              planner['email'].toLowerCase().contains(keyword.toLowerCase()) ||
              planner['name'].toLowerCase().contains(keyword.toLowerCase()) ||
              planner['location'].toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundPlanners = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
          title: const Text(
            "Search",
            style: TextStyle(
              fontFamily: 'Arial',
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () {},
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            style: const TextStyle(color: Color.fromARGB(255, 18, 140, 126)),
            decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Name or Place or Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: const Icon(Icons.search),
                suffixIconColor: const Color.fromARGB(255, 18, 140, 126)),
            onChanged: (value) => _filterList(value),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List>(
                future: planners.getAllPlanners(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    listCopy = snapshot.data!;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _foundPlanners.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 15,
                            color: Colors.black87,
                            child: Row(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.22,
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    child: Image.network(
                                        _foundPlanners[i]['profileIMG'],
                                        fit: BoxFit.fill)),
                                const SizedBox(width: 10.0),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          printName(_foundPlanners[i]['name']),
                                          //if(plannerLogedin)
                                            favourite(_foundPlanners[i]['plannerID']),
                                        ],
                                      ),
                                      //printName(_foundPlanners[i]['name']),
                                      const Text('Event Planner',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontStyle: FontStyle.italic)),
                                      //printRate(_foundPlanners[i]['rate']),
                                      printEmail(_foundPlanners[i]['email']),
                                      printPlace(_foundPlanners[i]['location'])
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewProfile(list: _foundPlanners, person: i)));
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CupertinoActivityIndicator( //Circularprogressbar
                        radius: 25.0,
                        color: Color.fromARGB(255, 18, 140, 126),
                      ),
                    );
                  }
                }),
          ),
        ]),
      ),
    );
  }

  Widget printName(String name) {
    return Text(name,
        style: const TextStyle(
            color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.bold));
  }

  Widget favourite(int foundPlanner){
    if(foundPlanner != currentuserid){
      return IconButton.outlined(
        icon:const Icon(Icons.favorite_border_outlined),
        color: Colors.white,
        onPressed: () {
          addFavourite(foundPlanner);
        },);                                             
    }
    else{
      return const SizedBox();
    }
}

  Widget printEmail(String email) {
    return Text(email,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.normal));
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

  Widget printPlace(String place) {
    return Text(place,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.normal));
  }

  Future<bool> addFavourite(int id) async {
    CurrentId currentuser = CurrentId();
    int currentuserId = currentuser.currentUserId;
    
    String hire = "http://127.0.0.1:8000/api/addToFavourite/$currentuserId/$id";   
    //String hire = "https://dreamy-wilson.34-81-183-3.plesk.page/api/addToFavourite/$currentuserId/$id";

    final response = await http.post(Uri.parse(hire));

    if (response.statusCode == 200) {
      print("favourite was successful");
      print("Response body: ${response.body}");
      return true;
    } 
    else {
      print("favourite failed with status code: ${response.statusCode}");
      return false;
    }
  }

}
