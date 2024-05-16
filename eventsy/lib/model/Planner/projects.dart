import 'package:eventsy/constants/constants.dart';
import 'package:eventsy/model/Planner/currentId.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Projects{

  CurrentId currentUser = CurrentId();

  Future<List> getBookRequests() async {
    int id = currentUser.currentUserId;
    final response = await http.post(Uri.parse('${url}getUserBookRequests/$id'));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else {
        return Future.error('Server Error');
    }
  }

  Future<List> getInProgress() async {
    int id = currentUser.currentUserId;
    final response = await http.post(Uri.parse('${url}getPlannerInProgress/$id'));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else {
        return Future.error('Server Error');
    }
  }

  Future<List> getComplete() async {
    int id = currentUser.currentUserId;
    final response = await http.post(Uri.parse('${url}getPlannerCompleted/$id'));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else {
        return Future.error('Server Error');
    }
  }

  Future<List> getCancelled() async {
    int id = currentUser.currentUserId;
    final response = await http.post(Uri.parse('${url}getPlannerCancelled/$id'));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else {
        return Future.error('Server Error');
    }
  }
}