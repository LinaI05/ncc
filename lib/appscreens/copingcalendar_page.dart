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
    final FirebaseAuth auth = FirebaseAuth.instance;
    final ref = FirebaseDatabase.instance.ref();
    final User? user = auth.currentUser;
    final uid = user?.uid;
    final snapshot = await ref.child('users/$uid/depression-calendar').get();
    final startDate = await ref.child('users/$uid/depression-sd').get();
    if (snapshot.exists) {
      if (snapshot.value == true) {
        addDepressionPlan(DateTime.parse(startDate.value as String));
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
        eventName: 'Day 1',
        background: Colors.pink,
        isAllDay: true,
        description: "-Journal"
            "-Guided PEMS",
      ));
      meetings.add(Meeting(
        from: startDate.add(
          Duration(days: 1)
        ),
        to: startDate.add(const Duration(days: 1, hours: 1)),
        eventName: 'Day 2',
        background: Colors.pink,
        isAllDay: true,
        description: "-Breathing with Purpose",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 2)),
        to: startDate.add(const Duration(days: 2, hours: 1)),
        eventName: 'Day 3',
        background: Colors.pink,
        isAllDay: true,
        description: "-Journal"
            "-Guided Relaxation",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 3)),
        to: startDate.add(const Duration(days: 3, hours: 1)),
        eventName: 'Day 4',
        background: Colors.pink,
        isAllDay: true,
        description: "-Guided Rejuvanation",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 4)),
        to: startDate.add(const Duration(days: 4, hours: 1)),
        eventName: 'Day 5',
        background: Colors.pink,
        isAllDay: true,
        description: "-Journal",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 5)),
        to: startDate.add(const Duration(days: 5, hours: 1)),
        eventName: 'Day 6',
        background: Colors.pink,
        isAllDay: true,
        description: "-Growing Kindness",
      ));
      meetings.add(Meeting(
        from: startDate.add(Duration(days: 6)),
        to: startDate.add(const Duration(days: 6, hours: 1)),
        eventName: 'Day 7',
        background: Colors.pink,
        isAllDay: true,
        description: "-Journal",
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
    return source[index].from!;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to!;
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
