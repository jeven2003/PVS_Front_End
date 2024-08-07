import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pvsfronend/Service/User.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey <FormState>();
  String email = '';
  String password ='';
  bool _obscure = true;
  IconData _obscureIcon = Icons.visibility_off;


  Widget buttonContent = Text('Login');
  Widget LoadingDisplay = CircularProgressIndicator();

  Future <bool>login(User user) async{
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/auth/login'),
      headers: <String, String>{
        'Content-Type' : 'application/json; charset=UTF-8 '
      },
      body: jsonEncode(<String, dynamic>{
        'usernameOrEmail' : user.email,
        'password' : user.password
      }),
    );
    if (response.statusCode ==200){
      return true;
    }
    return false;
    // print(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/pvlogo.jpg',
              height: 50.0,
              width: 50.0,
            ),
            SizedBox(width: 10.0),
            Text('PV Sportswear',
                style: TextStyle(fontWeight: FontWeight.bold,)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Login to your account',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Enter your email to login for this website',
              style: TextStyle(fontSize: 11.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),
            TextFormField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: Text(
                  'Email',
                  style:TextStyle(color: Colors.black),
                ),
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
              ),
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Provide an email';
                }
                return null;
              },
              onSaved: (value){
                email = value!;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              obscureText: _obscure,
              decoration: InputDecoration(
                label: Text(
                  'Password',
                  style:TextStyle(color: Colors.black),
                ),
                prefixIcon: Icon(Icons.lock_rounded),
                suffixIcon: IconButton(
                  icon: Icon(_obscureIcon),
                  onPressed:(){
                    setState(() {
                      _obscure = !_obscure;
                      if(_obscure){
                        _obscureIcon = Icons.visibility_off;
                      }else{
                        _obscureIcon = Icons.visibility;
                      }
                    });
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
              ),
              validator: (value){
                if(value==null|| value.isEmpty){
                  return'Provide a password';
                }
                if (value.length <8){
                  return'password should be atleast 8 characters long';
                }
                if (value.length>20){
                  return'Password must be 20 characters long';
                }
                return null;
              },
              onSaved: (value){
                password = value!;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {Navigator.pushReplacementNamed(context, '/dashboard');},
              child: Text('Login', style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),

            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {},
              child: Text('Forgot Password?', style: TextStyle(color: Colors.blue[600]),),
            ),
            SizedBox(height: 16.0),
            Text(
              "Don't have an account?",
              textAlign: TextAlign.center,
              style: TextStyle(color:Colors.grey[700]),
            ),
            SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: () { Navigator.pushReplacementNamed(context, '/signup');},
              child: Text('Create new account', style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}