import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../helpers/achievements-helper.dart';
import '../journalscreens/journal_page.dart';
import 'activities_page.dart';
import 'package:ncc/appscreens/landing_page.dart';

class CheckinScreen extends StatefulWidget {
  static const String id = 'checkin_screen';

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  void _navigateToLandingPage() {
    bool isRestless = _checks[0];
    bool isRelaxed = _checks[1];
    bool isStressed = _checks[2];
    bool isIndifferent = _checks[3];
    bool isSad = _checks[4];
    bool isEnthusiatic = _checks[5];
    bool isAnxious = _checks[6];
    bool isHappy = _checks[7];
    bool isHeavy = _checks[8];
    bool isLight = _checks[9];
    bool isImbalanced = _checks[10];
    bool isBalanced = _checks[11];

    // Show a dialog popup if the user is stressed or sad
    if (isSad) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: AlertDialog(
                  title: Text('Addressing Your Emotions!'),
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Looks like you are not feeling your best today. That\'s okay! Try Journaling, Guided Rejuvination, or Guided Affirmations in the ',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        TextSpan(
                            text: 'Activities',
                            style: const TextStyle(
                                color: Color(0xFFCF726A),
                                fontSize: 18.0,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Navigator.of(context).pop();
                                await pushNewScreenWithRouteSettings(
                                  context,
                                  settings:
                                      const RouteSettings(name: LandingPage.id),
                                  screen: const LandingPage(
                                    initialIndex: 1,
                                  ),
                                );
                              }),
                        const TextSpan(
                          text:
                              ' section of Restoring Mindsets to brighten you spiritis.',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                IconButton(
                  icon: Image.asset('assets/images/backButton.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: const RouteSettings(name: LandingPage.id),
                      screen: const LandingPage(
                        initialIndex: 0,
                      ),
                    );
                  },
                ),
              ]));
        },
      );
    } else if (isRestless || isStressed || isAnxious) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: AlertDialog(
                  title: Text('Addressing Your Emotions!'),
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Breathe in. Breathe out. Go out for breath of fresh air. Try Guided Meditation, Guided Relaxation, or Breathing with Purpose in the ',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        TextSpan(
                            text: 'Activities',
                            style: const TextStyle(
                                color: Color(0xFFCF726A),
                                fontSize: 18.0,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Navigator.of(context).pop();
                                await pushNewScreenWithRouteSettings(
                                  context,
                                  settings:
                                      const RouteSettings(name: LandingPage.id),
                                  screen: const LandingPage(
                                    initialIndex: 1,
                                  ),
                                );
                              }),
                        const TextSpan(
                          text:
                              ' section of Restoring Mindsets to calm your nerves and slow down your heart rate.',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                IconButton(
                  icon: Image.asset('assets/images/backButton.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: const RouteSettings(name: LandingPage.id),
                      screen: const LandingPage(
                        initialIndex: 0,
                      ),
                    );
                  },
                ),
              ]));
        },
      );
    } else if (isHeavy || isImbalanced) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: AlertDialog(
                  title: Text('Addressing Your Emotions!'),
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Understanding what you are feeling and why is the first step to addressing them. Try Guided PEMS or Guided Rejuvation in the ',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        TextSpan(
                            text: 'Activities ',
                            style: const TextStyle(
                                color: Color(0xFFCF726A),
                                fontSize: 18.0,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Navigator.of(context).pop();
                                await pushNewScreenWithRouteSettings(
                                  context,
                                  settings:
                                      const RouteSettings(name: LandingPage.id),
                                  screen: const LandingPage(
                                    initialIndex: 1,
                                  ),
                                );
                              }),
                        const TextSpan(
                          text:
                              ' section of Restoring Mindsets to recenter yourself.',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                IconButton(
                  icon: Image.asset('assets/images/backButton.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: const RouteSettings(name: LandingPage.id),
                      screen: const LandingPage(
                        initialIndex: 0,
                      ),
                    );
                  },
                ),
              ]));
        },
      );
    } else if (isRelaxed || isHappy || isEnthusiatic || isLight || isBalanced) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: AlertDialog(
                  title: Text('Addressing Your Emotions!'),
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Glad to see you are having a great day! Journal about it in the ',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        TextSpan(
                            text: 'Activities',
                            style: const TextStyle(
                                color: Color(0xFFCF726A),
                                fontSize: 18.0,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Navigator.of(context).pop();
                                await pushNewScreenWithRouteSettings(
                                  context,
                                  settings:
                                      const RouteSettings(name: LandingPage.id),
                                  screen: const LandingPage(
                                    initialIndex: 1,
                                  ),
                                );
                              }),
                        const TextSpan(
                          text:
                              ' section of Restoring Mindsets to remember and revist it in the future.',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                IconButton(
                  icon: Image.asset('assets/images/backButton.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: const RouteSettings(name: LandingPage.id),
                      screen: const LandingPage(
                        initialIndex: 0,
                      ),
                    );
                  },
                ),
              ]));
        },
      );
    } else if (isIndifferent) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: AlertDialog(
                  title: Text('Addressing Your Emotions!'),
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Glad to see you are doing okay. Try Guided Affirmations or Guided PEMS in the ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                        TextSpan(
                            text: 'Activities',
                            style: const TextStyle(
                                color: Color(0xFFCF726A),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Navigator.of(context).pop();
                                await pushNewScreenWithRouteSettings(
                                  context,
                                  settings:
                                      const RouteSettings(name: LandingPage.id),
                                  screen: const LandingPage(
                                    initialIndex: 1,
                                  ),
                                );
                              }),
                        const TextSpan(
                          text:
                              ' section of Restoring Mindsets to reassure your wellness.',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                IconButton(
                  icon: Image.asset('assets/images/backButton.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: const RouteSettings(name: LandingPage.id),
                      screen: const LandingPage(
                        initialIndex: 0,
                      ),
                    );
                  },
                ),
              ]));
        },
      );
    } else {
      // Navigate to the landing page
      pushNewScreenWithRouteSettings(
        context,
        settings: const RouteSettings(name: LandingPage.id),
        screen: const LandingPage(
          initialIndex: 0,
        ),
      );
    }
  }

  static const int _count = 12;
  List<String> emotionBank = [
    'Restless',
    'Relaxed',
    'Stressed',
    'Indifferent',
    'Sad',
    'Enthusiastic',
    'Anxious',
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
                          activeColor: Colors.black,
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
              onPressed: _navigateToLandingPage,
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
