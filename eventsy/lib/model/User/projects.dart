import 'package:eventsy/model/User/currentId.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Projects{

  CurrentId currentUser = CurrentId();

  Future<List> userBookings() async {
    int id = currentUser.currentUserId;
    final response = await http.post(Uri.parse('http://127.0.0.1:8000/api/getSentRequests/$id'));
    //final response = await http.post(Uri.parse('https://dreamy-wilson.34-81-183-3.plesk.page/api/getSentRequests/$id'));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else {
        return Future.error('Server Error');
    }
  }

  Future<List> getInProgress() async {
    int id = currentUser.currentUserId;
    final response = await http.post(Uri.parse('http://127.0.0.1:8000/api/getUserInProgress/$id'));
    //final response = await http.post(Uri.parse('https://dreamy-wilson.34-81-183-3.plesk.page/api/getUserInProgress/$id'));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else {
        return Future.error('Server Error');
    }
  }

  Future<List> getComplete() async {
    int id = currentUser.currentUserId;
    final response = await http.post(Uri.parse('http://127.0.0.1:8000/api/getUserComplete/$id'));
    //final response = await http.post(Uri.parse('https://dreamy-wilson.34-81-183-3.plesk.page/api/getUserComplete/$id'));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else {
        return Future.error('Server Error');
    }
  }

  Future<List> getCancelled() async {
    int id = currentUser.currentUserId;
    final response = await http.post(Uri.parse('http://127.0.0.1:8000/api/getUserCancelled/$id'));
    //final response = await http.post(Uri.parse('https://dreamy-wilson.34-81-183-3.plesk.page/api/getUserCancelled/$id'));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else {
        return Future.error('Server Error');
    }
  }
}