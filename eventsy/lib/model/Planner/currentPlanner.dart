import 'dart:convert';
import 'package:eventsy/constants/constants.dart';
import 'package:eventsy/model/Planner/currentId.dart';
import 'package:http/http.dart' as http;

class CurrentPlanner {
  
  
  Future<List> getCurrentPlanner() async {

    CurrentId currentuser = CurrentId();
    int id = currentuser.currentUserId;

    try {
      final response = await http.post(Uri.parse("${url}getCurrentPlanner/$id"));
      if (response.statusCode == 200) {
        //print([jsonDecode(response.body)]);
        return [jsonDecode(response.body)];
      } 
      else {
        return Future.error('Server Error');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
