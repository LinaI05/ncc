import 'package:flutter/material.dart';
import 'package:ncc/appscreens/audioplayer_page.dart';
import 'package:ncc/appscreens/cute_images_page.dart';
import 'package:ncc/journalscreens/journal_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class ActivitiesPage extends StatelessWidget {
  static String routeName = 'activitiesPage';
  static const int _count = 8;
  final List<bool> _checks = List.generate(_count, (index) => false);
  List<String> audioURLList = [
    '',
    'https://static.wixstatic.com/mp3/d7a5fa_01afb8828564401face98faae4c05b0e.mp3',
    'https://static.wixstatic.com/mp3/d7a5fa_089e67016c6b425c9808082a715cc582.mp3',
    'https://static.wixstatic.com/mp3/d7a5fa_4a37f5ca08e64f7e878b613acb551cae.mp3',
    'https://static.wixstatic.com/mp3/d7a5fa_4823a2677978479b8dd531cf907d173f.mp3',
    'https://static.wixstatic.com/mp3/d7a5fa_6086faa17cf74f13af12b1d1ef461e3b.mp3',
    'https://static.wixstatic.com/mp3/d7a5fa_5dc138a7bafa4ac18c188d102e5b89ce.mp3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 75.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Activities',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SourceSans',
                fontSize: 35.0,
              ),
            ),
            const Text(
              '*Scroll Down for more*',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SourceSans',
                fontSize: 15.0,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: _count,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (_, i) {
                  return IconButton(
                    onPressed: () {
                      if (i == 7) {
                        pushNewScreenWithRouteSettings(context,
                            settings:
                                RouteSettings(name: ActivitiesPage.routeName),
                            screen: CuteImagesClass(),
                            withNavBar: true);
                      } else if (i == 0) {
                        pushNewScreenWithRouteSettings(context,
                            settings:
                                RouteSettings(name: ActivitiesPage.routeName),
                            screen: JournalPage(),
                            withNavBar: true);
                      } else {
                        pushNewScreenWithRouteSettings(context,
                            settings:
                                RouteSettings(name: ActivitiesPage.routeName),
                            screen: AudioClass(audioURLList[i], i),
                            withNavBar: true);
                      }
                    },
                    icon: Image.asset('assets/activities/${i + 1}.png'),
                    iconSize: 100.0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}