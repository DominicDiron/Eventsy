import 'package:eventsy/controllers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRegisterPage extends StatelessWidget {
  const UserRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 140, 126),
        title: const Text('User Register'),
      ),
      body: const UserRegisterForm(),
    );
  }
}

class UserRegisterForm extends StatefulWidget {
  const UserRegisterForm({super.key});

  @override
  State<UserRegisterForm> createState() => _UserRegisterFormState();
}

class _UserRegisterFormState extends State<UserRegisterForm> {
  
  
  final TextEditingController profileIMGController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthenticationController authenticationController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: profileIMGController,
            decoration: const InputDecoration(labelText: 'Profile image Link'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: contactController,
            decoration: const InputDecoration(labelText: 'Contact'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: locationController,
            decoration: const InputDecoration(labelText: 'Location'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 20),
          Obx(() {
              return authenticationController.isLoading.value 
              ? const CircularProgressIndicator() 
              :
               ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 18, 140, 126)
                ),
                onPressed: () async{
                  await authenticationController.registerUser(context,
                    profileImg: profileIMGController.text.trim(),
                    name:nameController.text.trim(),
                    email:emailController.text.trim(),
                    contact:contactController.text.trim(),
                    password:passwordController.text.trim(),
                    location:locationController.text.trim(),
                    userType:"user");
                },
                child: const Text('Register'),
              );
            }
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Already have an account? Login',style: TextStyle(color: Color.fromARGB(255, 18, 140, 126))),
          ),
        ],
      ),
    );
  }
}