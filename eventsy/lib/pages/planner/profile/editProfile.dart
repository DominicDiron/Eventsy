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
  TextEditingController descriptionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController image1Controller = TextEditingController();
  TextEditingController image2Controller = TextEditingController();
  TextEditingController image3Controller = TextEditingController();
  TextEditingController image4Controller = TextEditingController();
  TextEditingController image5Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController serviceController = TextEditingController(); 

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
        descriptionController.text = person[0]['description'];
        locationController.text = person[0]['location'];
        image1Controller.text = person[0]['image1'];
        image2Controller.text = person[0]['image2'];
        image3Controller.text = person[0]['image3'];
        image4Controller.text = person[0]['image4'];
        emailController.text = person[0]['email'];
        contactController.text = person[0]['contact'];
        serviceController.text = person[0]['services'];
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
              buildTextField("Name", nameController.text, nameController, false),
              buildTextField("Profile image", "Paste your profile image url here", profileIMGController, false),
              buildTextField("Description", descriptionController.text,descriptionController, false),
              buildTextField("Password", "${person[0]['password']}",passwordController, true),
              buildTextField("Location", locationController.text,locationController, false),
              buildTextField("Sample image - 01", image1Controller.text, image1Controller, false),
              buildTextField("Sample image - 02", image2Controller.text, image2Controller, false),
              buildTextField("Sample image - 03", image3Controller.text, image3Controller, false),
              buildTextField("Sample image - 04", image4Controller.text, image4Controller, false),
              buildTextField("E-mail", emailController.text, emailController, false),
              buildTextField("Contact", contactController.text, contactController, false),
              buildTextField("Services", serviceController.text, serviceController, false),
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
                      bool result = await updateProfile();
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

  Future<bool> updateProfile() async {
    //List person = widget.user;
    final url ='http://127.0.0.1:8000/api/updateProfile/${person[0]['plannerID']}';
    //final url ='https://dreamy-wilson.34-81-183-3.plesk.page/api/updateProfile/${person[0]['plannerID']}';

    final response = await http.post(Uri.parse(url), body: {
      'name': nameController.text,
      'profileIMG': profileIMGController.text,
      'location': locationController.text,
      'image1': image1Controller.text,
      'image2': image2Controller.text,
      'image3': image3Controller.text,
      'image4': image4Controller.text,
      'image5': image5Controller.text,
      'email': emailController.text,
      'contact': contactController.text,
      'password': passwordController.text,
      'description': descriptionController.text,
      'services':serviceController.text,
    });
    //print(person[0]['plannerID']);
    if (response.statusCode == 200) {
      String msg = 'Profile updated successfully';
      print(msg);
      return true;
      
    } else {
      String msg = 'Error updating profile';
      print(response.statusCode );
      return false;
    }
  }

}
