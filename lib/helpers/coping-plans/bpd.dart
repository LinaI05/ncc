import 'package:flutter/material.dart';

import '../../appscreens/copingcalendar_page.dart';

void addBPDPlan(startDate) {
  MyList.meetings.add(Meeting(
    from: startDate,
    to: startDate.add(const Duration(hours: 1)),
    eventName: 'Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 1)),
    to: startDate.add(const Duration(days: 1, hours: 1)),
    eventName: 'Guided Relaxation',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 2)),
    to: startDate.add(const Duration(days: 2, hours: 1)),
    eventName: 'Guided Rejuvanation, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 3)),
    to: startDate.add(const Duration(days: 3, hours: 1)),
    eventName: 'Guided Affirmations',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 4)),
    to: startDate.add(const Duration(days: 4, hours: 1)),
    eventName: 'Guided Meditation, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 5)),
    to: startDate.add(const Duration(days: 5, hours: 1)),
    eventName: 'Guided PEMS',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 6)),
    to: startDate.add(const Duration(days: 6, hours: 1)),
    eventName: 'Breathing with Purpose, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 7)),
    to: startDate.add(const Duration(days: 7, hours: 1)),
    eventName: 'Guided Relaxation, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 8)),
    to: startDate.add(const Duration(days: 8, hours: 1)),
    eventName: 'Guided Rejuvenation, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 9)),
    to: startDate.add(const Duration(days: 9, hours: 1)),
    eventName: 'Breathing with Purpose, Guided Meditation',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 10)),
    to: startDate.add(const Duration(days: 10, hours: 1)),
    eventName: 'Guided Relaxation, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 11)),
    to: startDate.add(const Duration(days: 11, hours: 1)),
    eventName: 'Guided Affirmations, Guided PEMS',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 12)),
    to: startDate.add(const Duration(days: 12, hours: 1)),
    eventName: 'Cute Images, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 13)),
    to: startDate.add(const Duration(days: 13, hours: 1)),
    eventName: 'Guided Rejuvanation, Guided PEMS',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 14)),
    to: startDate.add(const Duration(days: 14, hours: 1)),
    eventName: 'Breathing with Purpose',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 15)),
    to: startDate.add(const Duration(days: 15, hours: 1)),
    eventName: 'Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 16)),
    to: startDate.add(const Duration(days: 16, hours: 1)),
    eventName: 'Guided Relaxation, Guided PEMS',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 17)),
    to: startDate.add(const Duration(days: 17, hours: 1)),
    eventName: 'Guided Affirmations',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 18)),
    to: startDate.add(const Duration(days: 18, hours: 1)),
    eventName: 'Guided Meditation, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 19)),
    to: startDate.add(const Duration(days: 19, hours: 1)),
    eventName: 'Guided PEMS, Breathing with Purpose',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 20)),
    to: startDate.add(const Duration(days: 20, hours: 1)),
    eventName: 'Guided Affirmations, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 21)),
    to: startDate.add(const Duration(days: 21, hours: 1)),
    eventName: 'Guided Rejuvanation',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 22)),
    to: startDate.add(const Duration(days: 22, hours: 1)),
    eventName: 'Guided Relaxation, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 23)),
    to: startDate.add(const Duration(days: 23, hours: 1)),
    eventName: 'Guided PEMS',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 24)),
    to: startDate.add(const Duration(days: 24, hours: 1)),
    eventName: 'Cute Images, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 25)),
    to: startDate.add(const Duration(days: 25, hours: 1)),
    eventName: 'Guided Affirmations',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 26)),
    to: startDate.add(const Duration(days: 26, hours: 1)),
    eventName: 'Breathing with Purpose, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 27)),
    to: startDate.add(const Duration(days: 27, hours: 1)),
    eventName: 'Guided Relaxation, Guided PEMS',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 28)),
    to: startDate.add(const Duration(days: 28, hours: 1)),
    eventName: 'Guided Rejuvenation',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 29)),
    to: startDate.add(const Duration(days: 29, hours: 1)),
    eventName: 'Guided Meditation, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 30)),
    to: startDate.add(const Duration(days: 30, hours: 1)),
    eventName: 'Guided Relaxation, Journal',
    background: const Color(0xFFF8B600),
    isAllDay: true,
    description: "BPD Coping Plan",
  ));
  MyList.saveMeetings();
}
