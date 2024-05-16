import 'package:eventsy/controllers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorRegisterPage extends StatelessWidget {
  const VendorRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 140, 126),
        title: const Text('Planner Register'),
      ),
      body: const VendorRegisterForm(),
    );
  }
}

class VendorRegisterForm extends StatefulWidget {
  const VendorRegisterForm({super.key});

  @override
  State<VendorRegisterForm> createState() => _VendorRegisterFormState();
}

class _VendorRegisterFormState extends State<VendorRegisterForm> {

  final TextEditingController profileIMGController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController image1Controller = TextEditingController();
  final TextEditingController image2Controller = TextEditingController();
  final TextEditingController image3Controller = TextEditingController();
  final TextEditingController image4Controller = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final AuthenticationController authenticationController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [Column(
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
                controller: image1Controller,
                decoration: const InputDecoration(labelText: 'Sample image link 1'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: image2Controller,
                decoration: const InputDecoration(labelText: 'Sample image link 2'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: image3Controller,
                decoration: const InputDecoration(labelText: 'Sample image link 3'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: image4Controller,
                decoration: const InputDecoration(labelText: 'Sample image link 4'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: serviceController,
                decoration: const InputDecoration(labelText: 'Services(seperated by comma)'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
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
                      backgroundColor: Color.fromARGB(255, 18, 140, 126)
                    ),
                    onPressed: () async{
                      await authenticationController.registerPlanner(context,
                        profileImg: profileIMGController.text.trim(),
                        name:nameController.text.trim(),
                        email:emailController.text.trim(),
                        contact:contactController.text.trim(),
                        password:passwordController.text.trim(),
                        location:locationController.text.trim(),
                        image1: image1Controller.text.trim(),
                        image2: image2Controller.text.trim(),
                        image3: image3Controller.text.trim(),
                        image4: image4Controller.text.trim(),
                        description: descriptionController.text.trim(),
                        services: serviceController.text.trim(),
                        userType:"planner");
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
     ] ),
      
    );
  }
}