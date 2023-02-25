import 'package:flutter/material.dart';
import 'package:ncc/appscreens/copingplans_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:ncc/helpers/achievements-helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../authentication.dart';

class copingCalendar extends StatefulWidget {
  const copingCalendar({Key? key}) : super(key: key);
  static String id = 'calendar-page';

  @override
  State<copingCalendar> createState() => _copingCalendarState();
}

class _copingCalendarState extends State<copingCalendar> {
  List<Meeting> meetings = <Meeting>[];
  MeetingDataSource? events;
  Meeting? _selectedAppointment;
  bool eventsFetched = false;

  @override
  void initState() {
    _selectedAppointment = null;
    meetings = <Meeting>[];
    setEvents();
    super.initState();
  }

  Future<void> setEvents() async {
    events = await _getCalendarDataSource();
    setState(() {
      eventsFetched = true;
    });
  }

  Widget displayPage(bool fetchEvents) {
    if (fetchEvents) {
      return (Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFE2CAF1),
          actions: [
            IconButton(
              onPressed: () {
                pushNewScreenWithRouteSettings(context,
                    settings: RouteSettings(name: 'copingPlans'),
                    screen: copingPlansPage(),
                    withNavBar: true);
              },
              icon: const Icon(
                Icons.add_box,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 30,
              child: TextButton(
                child: const Text('Remove appointment'),
                onPressed: () {
                  if (_selectedAppointment != null) {
                    events!.appointments.removeAt(
                        events!.appointments.indexOf(_selectedAppointment));
                    events!.notifyListeners(CalendarDataSourceAction.remove,
                        <Meeting>[]..add(_selectedAppointment!));
                  }
                },
              ),
            ),
            Container(
              height: 500,
              child: SfCalendar(
                view: CalendarView.month,
                allowedViews: const [
                  CalendarView.day,
                  CalendarView.week,
                  CalendarView.workWeek,
                  CalendarView.month,
                  CalendarView.timelineDay,
                  CalendarView.timelineWeek,
                  CalendarView.timelineWorkWeek,
                ],
                initialSelectedDate: DateTime.now(),
                monthViewSettings: const MonthViewSettings(showAgenda: true),
                dataSource: events,
                onTap: calendarTapped,
              ),
            ),
          ],
        ),
      ));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (guestLogin) {
      Future.delayed(Duration.zero, () => showGuestLoginAlert(context));
    }

    return VisibilityDetector(
      key: Key(copingCalendar.id),
      onVisibilityChanged: (VisibilityInfo info) {
        bool isVisible = info.visibleFraction != 0;
        if (isVisible == true) {
          eventsFetched = false;
          setEvents();
        }
      },
      child: displayPage(eventsFetched),
    );
  }

  Future<MeetingDataSource> _getCalendarDataSource() async {
    final FirebaseAuth authD = FirebaseAuth.instance;
    final refD = FirebaseDatabase.instance.ref();
    final User? userD = authD.currentUser;
    final uidD = userD?.uid;
    final snapshotD = await refD.child('users/$uidD/depression-calendar').get();
    final startDateD = await refD.child('users/$uidD/depression-sd').get();
    if (snapshotD.exists) {
      if (snapshotD.value == true) {
        addDepressionPlan(DateTime.parse(startDateD.value as String));
      } else {}
    } else {
      print("error");
    }

    final FirebaseAuth authA = FirebaseAuth.instance;
    final refA = FirebaseDatabase.instance.ref();
    final User? userA = authA.currentUser;
    final uidA = userA?.uid;
    final snapshotA = await refA.child('users/$uidA/anxiety-calendar').get();
    final startDateA = await refA.child('users/$uidA/anxiety-sd').get();
    if (snapshotA.exists) {
      if (snapshotA.value == true) {
        addAnxietyPlan(DateTime.parse(startDateA.value as String));
      } else {}
    } else {
      print("error");
    }

    return MeetingDataSource(meetings);
  }

  void addDepressionPlan(startDate) {
    if (meetings.isEmpty) {
      meetings.add(Meeting(
        from: startDate,
        to: startDate.add(const Duration(hours: 1)),
        eventName: '-Guided PEMS, Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 1",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 1)),
        to: startDate.add(const Duration(days: 1, hours: 1)),
        eventName: '-Breathing with Purpose',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 2",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 2)),
        to: startDate.add(const Duration(days: 2, hours: 1)),
        eventName: '-Guided Relaxation, Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 3",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 3)),
        to: startDate.add(const Duration(days: 3, hours: 1)),
        eventName: 'Guided Rejuvanation',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 4",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 4)),
        to: startDate.add(const Duration(days: 4, hours: 1)),
        eventName: '-Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 5",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 5)),
        to: startDate.add(const Duration(days: 5, hours: 1)),
        eventName: '-Cute Images',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 6",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 6)),
        to: startDate.add(const Duration(days: 6, hours: 1)),
        eventName: '-Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 7",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 8)),
        to: startDate.add(const Duration(days: 8, hours: 1)),
        eventName: '-Guided PEMS',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 8",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 9)),
        to: startDate.add(const Duration(days: 9, hours: 1)),
        eventName: '-Guided Rejuvanation',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 9",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 10)),
        to: startDate.add(const Duration(days: 10, hours: 1)),
        eventName: '-Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 10",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 11)),
        to: startDate.add(const Duration(days: 11, hours: 1)),
        eventName: '-Cute Images',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 11",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 12)),
        to: startDate.add(const Duration(days: 12, hours: 1)),
        eventName: '-Guided Relaxation, Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 12",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 13)),
        to: startDate.add(const Duration(days: 13, hours: 1)),
        eventName: '-Breathing with purpose',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 13",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 14)),
        to: startDate.add(const Duration(days: 14, hours: 1)),
        eventName: '-Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 14",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 15)),
        to: startDate.add(const Duration(days: 15, hours: 1)),
        eventName: '-Guided PEMS, Guided Affirmations',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 15",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 16)),
        to: startDate.add(const Duration(days: 16, hours: 1)),
        eventName: '-Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 16",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 17)),
        to: startDate.add(const Duration(days: 17, hours: 1)),
        eventName: '-Cute Images',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 17",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 18)),
        to: startDate.add(const Duration(days: 18, hours: 1)),
        eventName: '-Guided Relaxation, Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 18",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 19)),
        to: startDate.add(const Duration(days: 19, hours: 1)),
        eventName: '-Guided Rejuvanation',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 19",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 20)),
        to: startDate.add(const Duration(days: 20, hours: 1)),
        eventName: '-Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 20",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 21)),
        to: startDate.add(const Duration(days: 21, hours: 1)),
        eventName: '-Guided Affirmations',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 21",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 22)),
        to: startDate.add(const Duration(days: 22, hours: 1)),
        eventName: '-Guided PEMS, Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 22",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 23)),
        to: startDate.add(const Duration(days: 23, hours: 1)),
        eventName: '-Breathing with Purpose',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 23",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 24)),
        to: startDate.add(const Duration(days: 24, hours: 1)),
        eventName: '-Guided Affirmations, Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 24",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 25)),
        to: startDate.add(const Duration(days: 25, hours: 1)),
        eventName: '-Cute Images',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 25",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 26)),
        to: startDate.add(const Duration(days: 26, hours: 1)),
        eventName: '-Breathing with Purpose, Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 26",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 28)),
        to: startDate.add(const Duration(days: 28, hours: 1)),
        eventName: '-Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 28",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 29)),
        to: startDate.add(const Duration(days: 29, hours: 1)),
        eventName: '-Guided PEMS',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 29",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 30)),
        to: startDate.add(const Duration(days: 30, hours: 1)),
        eventName: '-Guided Rejuvanation, Journal',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 30",
      ));
    }
  }

  void addAnxietyPlan(startDate) {
    if (meetings.isEmpty) {
      meetings.add(Meeting(
        from: startDate,
        to: startDate.add(const Duration(hours: 1)),
        eventName: '-a',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 1",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 1)),
        to: startDate.add(const Duration(days: 1, hours: 1)),
        eventName: '-b',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 2",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 2)),
        to: startDate.add(const Duration(days: 2, hours: 1)),
        eventName: '-c',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 3",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 3)),
        to: startDate.add(const Duration(days: 3, hours: 1)),
        eventName: 'd',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 4",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 4)),
        to: startDate.add(const Duration(days: 4, hours: 1)),
        eventName: 'e',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 5",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 5)),
        to: startDate.add(const Duration(days: 5, hours: 1)),
        eventName: 'f',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 6",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 6)),
        to: startDate.add(const Duration(days: 6, hours: 1)),
        eventName: 'g',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 7",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 8)),
        to: startDate.add(const Duration(days: 8, hours: 1)),
        eventName: 'h',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 8",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 9)),
        to: startDate.add(const Duration(days: 9, hours: 1)),
        eventName: 'i',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 9",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 10)),
        to: startDate.add(const Duration(days: 10, hours: 1)),
        eventName: 'j',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 10",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 11)),
        to: startDate.add(const Duration(days: 11, hours: 1)),
        eventName: 'k',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 11",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 12)),
        to: startDate.add(const Duration(days: 12, hours: 1)),
        eventName: 'l',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 12",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 13)),
        to: startDate.add(const Duration(days: 13, hours: 1)),
        eventName: 'm',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 13",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 14)),
        to: startDate.add(const Duration(days: 14, hours: 1)),
        eventName: 'n',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 14",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 15)),
        to: startDate.add(const Duration(days: 15, hours: 1)),
        eventName: 'o',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 15",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 16)),
        to: startDate.add(const Duration(days: 16, hours: 1)),
        eventName: 'p',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 16",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 17)),
        to: startDate.add(const Duration(days: 17, hours: 1)),
        eventName: 'q',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 17",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 18)),
        to: startDate.add(const Duration(days: 18, hours: 1)),
        eventName: 'r',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 18",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 19)),
        to: startDate.add(const Duration(days: 19, hours: 1)),
        eventName: 's',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 19",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 20)),
        to: startDate.add(const Duration(days: 20, hours: 1)),
        eventName: 't',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 20",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 21)),
        to: startDate.add(const Duration(days: 21, hours: 1)),
        eventName: 'u',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 21",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 22)),
        to: startDate.add(const Duration(days: 22, hours: 1)),
        eventName: 'v',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 22",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 23)),
        to: startDate.add(const Duration(days: 23, hours: 1)),
        eventName: 'w',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 23",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 24)),
        to: startDate.add(const Duration(days: 24, hours: 1)),
        eventName: 'x',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 24",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 25)),
        to: startDate.add(const Duration(days: 25, hours: 1)),
        eventName: 'y',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 25",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 26)),
        to: startDate.add(const Duration(days: 26, hours: 1)),
        eventName: 'z',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 26",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 28)),
        to: startDate.add(const Duration(days: 28, hours: 1)),
        eventName: 'a1',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 28",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 29)),
        to: startDate.add(const Duration(days: 29, hours: 1)),
        eventName: 'b1',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 29",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 30)),
        to: startDate.add(const Duration(days: 30, hours: 1)),
        eventName: 'c1',
        background: Colors.pink,
        isAllDay: true,
        description: "Day 30",
      ));
    }
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Meeting appointment = calendarTapDetails.appointments![0];
      _selectedAppointment = appointment;
    }
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(this.source);

  List<Meeting> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  String getStartTimeZone(int index) {
    return source[index].startTimeZone;
  }

  @override
  String getEndTimeZone(int index) {
    return source[index].endTimeZone;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }
}

class Meeting {
  Meeting(
      {required this.from,
      required this.to,
      this.background = Colors.green,
      this.isAllDay = false,
      this.eventName = '',
      this.startTimeZone = '',
      this.endTimeZone = '',
      this.description = ''});

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  final String startTimeZone;
  final String endTimeZone;
  final String description;
}
