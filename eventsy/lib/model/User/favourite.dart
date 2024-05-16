
import 'dart:convert';

import 'package:eventsy/constants/constants.dart';
import 'package:eventsy/model/User/currentId.dart';
import 'package:http/http.dart' as http;

class UserFavourites{

  CurrentId currentUser = CurrentId();
  
  Future<List> getUserFavourites() async {
    int id = currentUser.currentUserId;
    final response = await http.post(Uri.parse('${url}getUserFavourites/$id'));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else {
        return Future.error('Server Error');
    }
  }
}