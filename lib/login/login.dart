import 'package:flutter/material.dart';
import 'package:ncc/constants.dart';
import 'package:ncc/appscreens/checkin.dart';

import '../authentication.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  String success = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Image.asset('assets/images/LoginIcon.png')),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Login',
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
                    decoration: kLoginFieldDecoration.copyWith(
                        hintText: 'Enter your email'),
                    enableSuggestions: false,
                    autocorrect: false,
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
                    decoration: kLoginFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFE2CAF1),
                      minimumSize: const Size(150, 45),
                      maximumSize: const Size(150, 45),
                      elevation: 7.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      AuthenticationHelper()
                          .signIn(email: email, password: password)
                          .then((error) {
                        if (error == null) {
                          Navigator.pushNamed(context, CheckinScreen.id);
                        } else {
                          setState(() {
                            success =
                                'There was an error with your login attempt.';
                          });
                        }
                      });
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFE2CAF1),
                      minimumSize: const Size(175, 45),
                      maximumSize: const Size(175, 45),
                      elevation: 7.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    icon: Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        fit: BoxFit.cover),
                    onPressed: () async {
                      // AuthenticationHelper().handleGoogleSignIn().then((error) {
                      //   if (error == null) {
                      //     Navigator.pushNamed(context, CheckinScreen.id);
                      //   } else {
                      //     setState(() {
                      //       success = 'There was an error with your login attempt.';
                      //     });
                      //   }
                      // });
                      try {
                        await AuthenticationHelper().signInwithGoogle();
                        Navigator.pushNamed(context, CheckinScreen.id);
                      } catch (e) {
                        setState(() {
                          success =
                              'There was an error with your login attempt.';
                        });
                      }
                    },
                    label: const Text(
                      'Sign in With Google',
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
              ),
            ),
          )),
    );
  }
}

// class login extends StatefulWidget {
//   static const String id = 'login_screen';
//   //static
//   //@override
//   //State<login> createState() => _loginState();
// }

// class _loginState extends State<login> {
//  const String _title = '';
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("<--"),
//           backgroundColor: Colors.white,
//         ),
//         body: const MyStatefulWidget(),
//       ),
//     );
//   }
// }
