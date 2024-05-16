import 'dart:convert';
import 'package:eventsy/constants/constants.dart';
import 'package:http/http.dart' as http;

class Planners {

  Future<List> getAllPlanners() async {
    try {
      final response = await http.post(Uri.parse("${url}planners"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error('Server Error');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
