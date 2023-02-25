import 'package:flutter/material.dart';
import 'package:ncc/helpers/achievements-helper.dart';

class copingPlansPage extends StatefulWidget {
  const copingPlansPage({Key? key}) : super(key: key);

  @override
  State<copingPlansPage> createState() => _copingPlansPageState();
}

class _copingPlansPageState extends State<copingPlansPage> {
  bool isSwitchedD = false;
  bool isSwitchedA = false;

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
              Spacer(),
              Row(
                children: [
                  ElevatedButton(
                    child: const Text(
                      'Depression',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SourceSans',
                        fontSize: 29.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCF726A),
                      minimumSize: const Size(250, 60),
                      maximumSize: const Size(250, 60),
                      elevation: 7.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {},
                  ),
                  Switch.adaptive(
                    value: isSwitchedD,
                    onChanged: (newValue) {
                      if (newValue == true) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Add Event to Calendar"),
                              content: Text(
                                  "Would you like to add the events of the depression calendar to your own?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      isSwitchedD = newValue;
                                    });
                                    await updateDepressionCalendar();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Yes"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {}
                    },
                  )
                ],
              ),
              Spacer(),
              Row(
                children: [
                  ElevatedButton(
                    child: const Text(
                      'Anxiety',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SourceSans',
                        fontSize: 29.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF78BA7D),
                      minimumSize: const Size(250, 60),
                      maximumSize: const Size(250, 60),
                      elevation: 7.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {},
                  ),
                  Switch.adaptive(
                    value: isSwitchedA,
                    onChanged: (newValue) {
                      if (newValue == true) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Add Event to Calendar"),
                              content: Text(
                                  "Would you like to add the events of the Anxiety calendar to your own?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      isSwitchedA = newValue;
                                    });
                                    await updateAnxietyCalendar();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Yes"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {}
                    },
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                child: const Text(
                  'PTSD',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SourceSans',
                    fontSize: 29.0,
                  ),
                ),
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
              ),
              Spacer(),
              ElevatedButton(
                child: const Text(
                  'BPD',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SourceSans',
                    fontSize: 29.0,
                  ),
                ),
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
              ),
              Spacer(),
              ElevatedButton(
                child: const Text(
                  'OCD',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SourceSans',
                    fontSize: 29.0,
                  ),
                ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
