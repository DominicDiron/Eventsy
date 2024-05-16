import 'package:eventsy/model/Planner/currentPlanner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class edit_profile extends StatefulWidget {
  final List user;
  const edit_profile({super.key, required this.user});

  @override
  State<edit_profile> createState() => _edit_profileState(user);
}

class _edit_profileState extends State<edit_profile> {
  List person;
  _edit_profileState(this.person);

  bool isObsurePassword = true;
  CurrentPlanner currentPlanner = CurrentPlanner();

  //controllers for handling editings
  TextEditingController nameController = TextEditingController();
  TextEditingController profileIMGController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      setState(() {
        // Populate text fields with user data
        nameController.text = person[0]['name'];
        profileIMGController.text = person[0]['profileIMG'];
        locationController.text = person[0]['location'];
        emailController.text = person[0]['email'];
        contactController.text = person[0]['contact'];
      });
    } catch (e) {
      // Handle error
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    //List person = widget.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: const BackButton(),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: const Color.fromARGB(255, 18, 140, 126)),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(person[0]['profileIMG']))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Colors.white,
                              ),
                              color: Colors.blue),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              buildTextField(
                  "Name", nameController.text, nameController, false),
                  buildTextField(
                  "Profile image", "Paste your profile image url here", profileIMGController, false),
              buildTextField("Password", "${person[0]['password']}",
                  passwordController, true),
              buildTextField("Location", locationController.text,
                  locationController, false),
              buildTextField(
                  "E-mail", emailController.text, emailController, false),
              buildTextField(
                  "Contact", contactController.text, contactController, false),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      // Show a confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Discard Changes?'),
                            content: const Text(
                                'Are you sure you want to discard the changes?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Close the dialog and navigate back without saving
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Close the dialog and navigate back to the previous screen
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 15, letterSpacing: 2, color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool result = await updateUserProfile();
                      if(result){
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 18, 140, 126),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 15, letterSpacing: 2, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String lableText, String placeholder,
      TextEditingController controller, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        
        obscureText: isPasswordTextField ? isObsurePassword : false,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObsurePassword = !isObsurePassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ))
                : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: lableText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )),
      ),
    );
  }

  Future<bool> updateUserProfile() async {
    final url ='http://127.0.0.1:8000/api/updateUserProfile/${person[0]['userID']}';
    //final url ='https://dreamy-wilson.34-81-183-3.plesk.page/api/updateUserProfile/${person[0]['userID']}';

    final response = await http.post(Uri.parse(url), body: {
      'name': nameController.text,
      'profileIMG': profileIMGController.text,
      'location': locationController.text,
      'email': emailController.text,
      'contact': contactController.text,
    });

    if (response.statusCode == 200) {
      String msg = 'Profile updated successfully';
      print(msg);
      return true;
      
    } else {
      String msg = 'Error updating profile';
      print(msg );
      return false;
    }
  }

}
