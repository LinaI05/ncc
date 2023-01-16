import 'package:flutter/material.dart';
import 'package:ncc/appscreens/emotion_detect_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'landing_page.dart';

class CheckinScreen extends StatefulWidget {
  static const String id = 'checkin_screen';
  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  static const int _count = 12;
  List<String> emotionBank = [
    'Restless',
    'Relaxed',
    'Stressed',
    'Indifferent',
    'Sad',
    'Enthusiastic',
    'Anxiety',
    'Happy',
    'Heavy',
    'Light',
    'Imbalanced',
    'Balanced',
  ];
  final List<bool> _checks = List.generate(_count, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
            top: 60.0, left: 5.0, right: 5.0, bottom: 30.0),
        child: Column(
          children: <Widget>[
            Align(
              child: IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () {
                  // pushNewScreenWithRouteSettings(
                  //   context,
                  //   screen: EmotionPage(),
                  //   settings: RouteSettings(name: LandingPage.id),
                  // );
                },
              ),
            ),
            const Text(
              'What are you feeling today?',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SourceSans',
                fontSize: 25.0,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: _count,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (_, i) {
                  return Column(
                    children: <Widget>[
                      Theme(
                        child: Checkbox(
                          activeColor: Colors.transparent,
                          value: _checks[i],
                          onChanged: (newValue) =>
                              setState(() => _checks[i] = newValue!),
                        ),
                        data: ThemeData(
                          primarySwatch: Colors.grey,
                          unselectedWidgetColor: Colors.black,
                        ),
                      ),
                      Text(
                        emotionBank[i],
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'SourceSans',
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                          child: Image.asset('assets/checkin/${i + 1}.png')),
                    ],
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () {
                pushNewScreenWithRouteSettings(
                  context,
                  screen: LandingPage(),
                  settings: RouteSettings(name: LandingPage.id),
                );
                //Navigator.pushNamed(context, LandingPage.id);
              },
              icon: Image.asset('assets/images/backButton.png'),
            ),
          ],
        ),
      ),
    );
  }
}

// onPressed: () async {
// AuthenticationHelper().signOut().then((error) {
// if (error == null) {
// Navigator.pop(context);
// } else {}
// });
// },
