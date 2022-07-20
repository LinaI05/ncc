import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 4.0),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30),
              child: const Text(
                'Welcome to Joining the Journey',
                style: (TextStyle(fontSize: 30, fontFamily: 'Italianno')),
              ),
            ),
            Container(
                height: 250,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/pigina.png',
                  height: 250,
                  width: 250,
                )),
            Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(50, 29, 50, 0),
                child: ElevatedButton(
                    child: const Text('Get Started!',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SourceSans',
                          fontSize: 22,
                        )),
                    onPressed: () {
                      print(nameController.text);
                      print(passwordController.text);
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(9.0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green.shade300),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18.0)))))),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.green,
                  decoration: TextDecoration.underline,
                  fontFamily: 'SourceSans',
                ),
              ),
            ),
          ],
        ));
  }
}
