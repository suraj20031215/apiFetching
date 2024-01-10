import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myappdemo/home.dart';
import 'package:myappdemo/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {

  TextEditingController usercon = TextEditingController();
  TextEditingController passcon = TextEditingController();
  Map<String,dynamic> mydata ={};


  Future<void> loginUser() async {
    final String apiUrl = 'http://172.16.2.144:8000/api/user/login';

    // Create a Map for the request body
    final Map<String, String> data = {
      'email':usercon.text.toString(),
      'password': passcon.text.toString(),
    };

    // Encode the data to JSON
    // final String encodedData = jsonEncode(data);

    try {
      // Send the POST request
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: data,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the response body (assuming it's JSON)
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Now you can handle the response data as needed
        print('Login successful: $responseData');

        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
      } else {
        // Handle errors
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      // Handle network or other errors
      print('error kyu aa raha h bhai');
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
              controller: usercon,
              decoration: InputDecoration(hintText: 'Enter Your Email',border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passcon,
              decoration: InputDecoration(hintText: 'Enter Your Password',border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: (){
                if(usercon.value.text.isEmpty  && passcon.value.text.isEmpty){
          print('fill details first');
                }else{
                loginUser();
                }
              },
            child: Text('Login Now'),),
            SizedBox(
              height: 20,
            ),

            MaterialButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen(),));
            },child:Text('Sign UP Page'))
          ],
        ),
      ),

    );
  }
}
