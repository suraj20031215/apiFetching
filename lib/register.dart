import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();


  Future<void> registerUser() async {
    final String apiUrl = 'http://172.16.2.144:8000/api/user/register';

    final Map<String, dynamic> userData = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': mobileController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
       
        print('User registered successfully');

      } else {

        print('Failed to register user. Status code: ${response.statusCode}');

      }
    } catch (e) {
      // Exception occurred during the HTTP request
      print('Error sending registration request: $e');
      // You can handle the exception here if needed
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
   controller: nameController,
              decoration: InputDecoration(hintText: 'Enter Your Name',border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
            ),
            SizedBox(height:10),
            TextField(
             controller: emailController,
              decoration: InputDecoration(hintText: 'Enter Your Email',border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
            ),
            SizedBox(height:10),
            TextField(
             controller: passwordController,
              decoration: InputDecoration(hintText: 'Enter Your Password',border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
            ),
            SizedBox(height:10),
            TextField(
         controller: mobileController,
              decoration: InputDecoration(hintText: 'Enter Your Phone Number',border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
            ),
            SizedBox(height:10),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                registerUser();
              },
            child: Text('Register Here..'),)

          ],
        ),
      ),


    );
  }
}
