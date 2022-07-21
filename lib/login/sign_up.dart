import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ncc/constants.dart';
import 'package:ncc/appscreens/home_page.dart';

import '../authentication.dart';

class SignupScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email = '';
  String password = '';
  String success = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/images/star.png')),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign up',
                  style: (TextStyle(fontSize: 35)),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                onChanged: (value) {
                  email = value;
                },
                decoration: kSignupFieldDecoration.copyWith(
                    hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                onChanged: (value) {
                  password = value;
                },
                decoration: kSignupFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFFFE999),
                  minimumSize: const Size(150, 45),
                  maximumSize: const Size(150, 45),
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  AuthenticationHelper()
                      .signUp(email: email, password: password)
                      .then((error) {
                    if (error == null) {
                      Navigator.pushNamed(context, HomePage.id);
                    } else {
                      // Scaffold.of(context).showSnackBar(SnackBar(
                      //   content: Text(
                      //     error,
                      //     style: TextStyle(fontSize: 16),
                      //   ),
                      // ));
                      setState(() {
                        success =
                            'There was an error with your sign in attempt.';
                      });
                    }
                  });
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                success,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          )),
    );
  }
}
