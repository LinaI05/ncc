import 'package:flutter/material.dart';
import 'package:ncc/appscreens/profile_page.dart';
import 'package:ncc/authentication.dart';
import 'package:ncc/start_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

Future<String> getDisplayName() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user = await auth.currentUser!;
  if (user.displayName == null) {
    return 'Your Name';
  } else {
    return user.displayName!;
  }
}

Future<String> getSelectedPhoto() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user = await auth.currentUser!;
  if (user.photoURL == null) {
    return 'assets/images/avatar.png';
  } else {
    return user.photoURL!;
  }
}

class settingsPage extends StatelessWidget {
  static String routeName = 'profilepage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Center(
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SourceSans',
                  fontSize: 35.0,
                ),
              ),
            ),
            FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error} occurred',
                      style: TextStyle(fontFamily: 'SourceSans'),
                    );
                  } else {
                    final data = snapshot.data as String;
                    return Image.asset(
                      data,
                      height: 150.0,
                    );
                  }
                }
                return Text('operation could not be completed');
              },
              future: getSelectedPhoto(),
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Image.asset(
            //     'assets/images/avatar.png',
            //     height: 150.0,
            //   ),
            // ),
            FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontFamily: 'SourceSans'),
                    );
                  } else {
                    final data = snapshot.data as String;
                    return Center(
                      child: Text(
                        data,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'SourceSans',
                          fontSize: 25.0,
                        ),
                      ),
                    );
                  }
                }
                return Text('operation could not be completed');
              },
              future: getDisplayName(),
            ),
            // const Center(
            //   child: Text(
            //     'Your Name',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontFamily: 'SourceSans',
            //       fontSize: 20.0,
            //     ),
            //   ),
            // ),
            SettingTile(
              titleText: 'Profile',
              textSize: 30.0,
              tileColor: Color(0xFFA686C7),
              onTap: () {
                pushNewScreenWithRouteSettings(context,
                    settings: RouteSettings(name: settingsPage.routeName),
                    screen: ProfilePage(),
                    withNavBar: true);
              },
            ),
            SettingTile(
              titleText: 'Log Out',
              textSize: 30.0,
              tileColor: Color(0xFFCF726A),
              onTap: () {
                // Navigator.of(context).popUntil((route) {
                //   return route.settings.name == LoginScreen.id;
                // });
                //Navigator.pushNamed(context, LoginScreen.id);
                // Navigator.popUntil(
                //     context, ModalRoute.withName(LoginScreen.id));
                // print("hello");
                AuthenticationHelper().signOut().then((error) {
                  if (error == null) {
                    // pushNewScreen(context,
                    //     screen: StartScreen(), withNavBar: false);
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName('start_screen'));
                    pushNewScreen(context,
                        screen: StartScreen(), withNavBar: false);
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(builder: (context) => StartScreen()),
                    //     (Route<dynamic> route) => false);
                  } else {}
                });
              },
            ),
            SettingTile(
              titleText: 'Hotlines',
              textSize: 30.0,
              tileColor: Color(0xFF78BA7D),
              onTap: () async {
                const url = 'https://www.pleaselive.org/hotlines/';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  throw "Could not launch $url";
                }
              },
            ),
            // SettingTile(
            //   titleText: 'Coping Plan',
            //   textSize: 30.0,
            //   tileColor: Color(0xFF2FA9C0),
            //   onTap: () {},
            // ),
            SettingTile(
              titleText: 'Additional Resources',
              textSize: 25.0,
              tileColor: Color(0xFFF8B600),
              onTap: () async {
                const url = 'http://www.novice.org/';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  throw "Could not launch $url";
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  String titleText;
  double textSize;
  VoidCallback onTap;
  Color tileColor;

  SettingTile(
      {required this.titleText,
      required this.textSize,
      required this.tileColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      tileColor: tileColor,
      title: Text(
        titleText,
        style: TextStyle(fontSize: textSize, color: Colors.white),
      ),
      visualDensity: VisualDensity(vertical: 4),
      dense: false,
      trailing: Image.asset('assets/images/backButton.png'),
      onTap: onTap,
    );
  }
}
