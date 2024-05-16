import 'dart:convert';
import 'package:eventsy/constants/constants.dart';
import 'package:eventsy/pages/login.dart';
import 'package:eventsy/pages/planner/dashboard.dart';
import 'package:eventsy/pages/user/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  Map currentUser = {};
  int currentUserId = 0;
  final box = GetStorage();

  Future registerUser(BuildContext context,
      {required String profileImg,
      required String name,
      required String contact,
      required String email,
      required String password,
      required String location,
      required String userType}) async {
    try {
      isLoading.value = true;
      var data = {
        'profileIMG': profileImg,
        'name': name,
        'email': email,
        'contact': contact,
        'location': location,
        'password': password,
        'userType': userType
      };

      var response = await http.post(
        Uri.parse('${url}register'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Navigator.pop(context);
      } else {
        isLoading.value = false;
        Get.snackbar('Error', json.decode(response.body)['Error'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3));
        print(json.decode(response.body)['message']);
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future registerPlanner(BuildContext context,
      {required String profileImg,
      required String name,
      required String contact,
      required String email,
      required String password,
      required String location,
      required String image1,
      required String image2,
      required String image3,
      required String image4,
      required String services,
      required String description,
      required String userType,}) async {
    try {
      isLoading.value = true;
      var data = {
        'profileIMG': profileImg,
        'name': name,
        'email': email,
        'contact': contact,
        'location': location,
        'password': password,
        'image1': image1,
        'image2': image2,
        'image3': image3,
        'image4': image4,
        'services': services,
        'description': description,
        'userType': userType
      };

      var response = await http.post(
        Uri.parse('${url}register'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Navigator.pop(context);
      } else {
        isLoading.value = false;
        Get.snackbar('Error', json.decode(response.body)['Error'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3));
        print(json.decode(response.body)['message']);
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future login(BuildContext context,
      {required String email,
      required String password,
      required String userType}) async {
    try {
      isLoading.value = true;
      print(userType);
      var data = {
        'email': email,
        'password': password,
        'userType': userType,
      };

      var response = await http.post(
        Uri.parse('${url}login'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        currentUser = json.decode(response.body)['user'];

        if (userType == "Planner") {
          currentUserId = json.decode(response.body)['user']['plannerID'];
          print(json.decode(response.body)['user']);
          box.write('token', token.value);
          box.write('id', currentUserId);
          print(box.read('id'));
          // Get.offAll(()=>const Dashboard());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PlannerDashboard()));
        } else if (userType == "User") {
          currentUserId = json.decode(response.body)['user']['userID'];
          print(json.decode(response.body)['user']);
          box.write('token', token.value);
          box.write('id', currentUserId);
          print(box.read('id'));
          // Get.offAll(()=>const Dashboard());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserDashboard()));
        }
      } else {
        isLoading.value = false;
        Get.snackbar('Error', json.decode(response.body)['Error'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3));
        print(json.decode(response.body)['message']);
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
