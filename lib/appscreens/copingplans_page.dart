import 'package:flutter/material.dart';
import 'package:ncc/helpers/achievements-helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ncc/appscreens/copingcalendar_page.dart';
import 'package:ncc/helpers/coping-plans/depression.dart';
import 'package:ncc/helpers/coping-plans/anxiety.dart';
import 'package:ncc/helpers/coping-plans/ptsd.dart';
import 'package:ncc/helpers/coping-plans/ocd.dart';
import 'package:ncc/helpers/coping-plans/bpd.dart';

class copingPlansPage extends StatefulWidget {
  const copingPlansPage({Key? key}) : super(key: key);

  @override
  State<copingPlansPage> createState() => _copingPlansPageState();
}

class _copingPlansPageState extends State<copingPlansPage> {
  late SharedPreferences prefs;
  bool switchD = false;
  bool switchA = false;
  bool switchP = false;
  bool switchB = false;
  bool switchO = false;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  @override
  void dispose() {
    prefs.setBool(
        'switchD', switchD); // save switchD value before closing the app
    prefs.setBool('switchA', switchA);
    prefs.setBool('switchP', switchP);
    prefs.setBool('switchB', switchB);
    prefs.setBool('switchO', switchO);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      switchD = prefs.getBool('switchD') ?? false;
      switchA = prefs.getBool('switchA') ?? false;
      switchP = prefs.getBool('switchP') ?? false;
      switchB = prefs.getBool('switchB') ?? false;
      switchO = prefs.getBool('switchO') ?? false;
    });
  }

  void deleteDepressionPlan() {
    MyList.meetings.removeWhere(
        (meeting) => meeting.description == 'Depression Coping Plan');
    MyList.saveMeetings();
  }

  void deleteAnxietyPlan() {
    MyList.meetings
        .removeWhere((meeting) => meeting.description == 'Anxiety Coping Plan');
    MyList.saveMeetings();
  }

  void deletePTSDPlan() {
    MyList.meetings
        .removeWhere((meeting) => meeting.description == 'PTSD Coping Plan');
    MyList.saveMeetings();
  }

  void deleteBPDPlan() {
    MyList.meetings
        .removeWhere((meeting) => meeting.description == 'BPD Coping Plan');
    MyList.saveMeetings();
  }

  void deleteOCDPlan() {
    MyList.meetings
        .removeWhere((meeting) => meeting.description == 'OCD Coping Plan');
    MyList.saveMeetings();
  }

  void handleSwitchDChanged(bool value) async {
    if (!value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Plan from Calendar"),
            content: const Text(
              "Would you like to delete the events of the Depression Coping Plan from your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchD', true);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await deleteDepressionCalendar();
                  await prefs.setBool('switchD', false);
                  setState(() {
                    switchD = false;
                  });
                  Navigator.of(context).pop(); // dismiss dialog
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Plan to Calendar"),
            content: const Text(
              "Would you like to add the events of the Depression Coping Plan to your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchD', false);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await updateDepressionCalendar();
                  addDepressionPlan(DateTime.now());
                  await prefs.setBool('switchD', true);
                  setState(() {
                    switchD = true;
                  });
                  Navigator.of(context).pop(); // dismiss dialog
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }
  }

  void handleSwitchAChanged(bool value) async {
    if (!value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Plan from Calendar"),
            content: const Text(
              "Would you like to delete the events of the Anxiety Coping Plan from your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchA', true);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await deleteAnxietyCalendar();
                  await prefs.setBool('switchA', false);
                  setState(() {
                    switchA = false;
                  });
                  Navigator.of(context).pop(); // dismiss dialog
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Plan to Calendar"),
            content: const Text(
              "Would you like to add the events of the Anxiety Coping Plan to your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchA', false);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await updateAnxietyCalendar();
                  addAnxietyPlan(DateTime.now());
                  await prefs.setBool('switchA', true);
                  setState(() {
                    switchA = true;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }
  }

  void handleSwitchPChanged(bool value) async {
    if (!value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Plan from Calendar"),
            content: const Text(
              "Would you like to delete the events of the PTSD Coping Plan from your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchP', true);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await deletePTSDCalendar();
                  await prefs.setBool('switchP', false);
                  setState(() {
                    switchP = false;
                  });
                  Navigator.of(context).pop(); // dismiss dialog
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Plan to Calendar"),
            content: const Text(
              "Would you like to add the events of the PTSD Coping Plan to your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchP', false);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await updatePTSDCalendar();
                  addPTSDPlan(DateTime.now());
                  await prefs.setBool('switchP', true);
                  setState(() {
                    switchP = true;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }
  }

  void handleSwitchBChanged(bool value) async {
    if (!value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Plan from Calendar"),
            content: const Text(
              "Would you like to delete the events of the BPD Coping Plan from your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchB', true);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await deleteBPDCalendar();
                  await prefs.setBool('switchB', false);
                  setState(() {
                    switchB = false;
                  });
                  Navigator.of(context).pop(); // dismiss dialog
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Plan to Calendar"),
            content: const Text(
              "Would you like to add the events of the BPD Coping Plan to your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchB', false);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await updateBPDCalendar();
                  addBPDPlan(DateTime.now());
                  await prefs.setBool('switchB', true);
                  setState(() {
                    switchB = true;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }
  }

  void handleSwitchOChanged(bool value) async {
    if (!value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Plan from Calendar"),
            content: const Text(
              "Would you like to delete the events of the OCD Coping Plan from your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchO', true);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await deleteOCDCalendar();
                  await prefs.setBool('switchO', false);
                  setState(() {
                    switchO = false;
                  });
                  Navigator.of(context).pop(); // dismiss dialog
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Plan to Calendar"),
            content: const Text(
              "Would you like to add the events of the OCD Coping Plan to your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchO', false);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await updateOCDCalendar();
                  addOCDPlan(DateTime.now());
                  await prefs.setBool('switchO', true);
                  setState(() {
                    switchO = true;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 65.0,
          left: 25.0,
          right: 25.0,
          bottom: 50.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pick a Coping Plan',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SourceSans',
                  fontSize: 40.0,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCF726A),
                      minimumSize: const Size(300, 60),
                      maximumSize: const Size(300, 60),
                      elevation: 7.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Depression',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SourceSans',
                        fontSize: 29.0,
                      ),
                    ),
                  ),
                  Switch.adaptive(
                    value: switchD,
                    onChanged: handleSwitchDChanged,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF78BA7D),
                      minimumSize: const Size(300, 60),
                      maximumSize: const Size(300, 60),
                      elevation: 7.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Anxiety',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SourceSans',
                        fontSize: 29.0,
                      ),
                    ),
                  ),
                  Switch.adaptive(
                    value: switchA,
                    onChanged: handleSwitchAChanged,
                  ),
                ],
              ),
              Spacer(),
              Row(children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2FA9C0),
                    minimumSize: const Size(300, 60),
                    maximumSize: const Size(300, 60),
                    elevation: 7.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'PTSD',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SourceSans',
                      fontSize: 29.0,
                    ),
                  ),
                ),
                Switch.adaptive(
                  value: switchP,
                  onChanged: handleSwitchPChanged,
                ),
              ]),
              const Spacer(),
              Row(children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF8B600),
                    minimumSize: const Size(300, 60),
                    maximumSize: const Size(300, 60),
                    elevation: 7.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'BPD',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SourceSans',
                      fontSize: 29.0,
                    ),
                  ),
                ),
                Switch.adaptive(
                  value: switchB,
                  onChanged: handleSwitchBChanged,
                ),
              ]),
              const Spacer(),
              Row(children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C5F99),
                    minimumSize: const Size(300, 60),
                    maximumSize: const Size(300, 60),
                    elevation: 7.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'OCD',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SourceSans',
                      fontSize: 29.0,
                    ),
                  ),
                ),
                Switch.adaptive(
                  value: switchO,
                  onChanged: handleSwitchOChanged,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
