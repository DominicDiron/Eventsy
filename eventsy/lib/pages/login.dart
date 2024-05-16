import 'package:eventsy/controllers/authentication.dart';
import 'package:eventsy/pages/planner/register.dart';
import 'package:eventsy/pages/user/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 140, 126),
        title: const Text('Login'),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  String dropdownValue = 'Planner';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Icon(Icons.pix, color: Color.fromARGB(255, 18, 140, 126), size: 100),
          const SizedBox(
              height: 40.0,
              child: Text(
                "Eventsy",
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 30,
                  color: Color.fromARGB(255, 18, 140, 126),
                ),
                textAlign: TextAlign.center,
              ),
            ), 
          const SizedBox(height: 50),
          DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Planner', 'User']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 18, 140, 126)
            ),
            onPressed: () async {
              await authenticationController.login(context,
                  userType: dropdownValue,
                  email: emailController.text.trim(),
                  password: passwordController.text);
            },
            child: Obx(() {
              return authenticationController.isLoading.value
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text('Login');
            }),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const UserRegisterPage()));
            },
            child: const Text('Register as normal user',style: TextStyle(color: Color.fromARGB(255, 18, 140, 126))),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.push( context,MaterialPageRoute(builder: (context) => const VendorRegisterPage()));
            },
            child: const Text('Register as planner',style: TextStyle(color: Color.fromARGB(255, 18, 140, 126))),
          ),
        ],
      ),
    );
  }
}