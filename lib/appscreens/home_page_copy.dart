import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:ncc/constants.dart';
import 'package:ncc/helpers/api-helper.dart';
import 'package:ncc/helpers/affirmations-helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ncc/helpers/quote.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

Future<AffirmationsModel> fetchAffirmations() async {
  final response = await http.get(Uri.parse('https://www.affirmations.dev/'));
  if (response.statusCode == 200) {
    final jsonAffirmations = jsonDecode(response.body);
    return AffirmationsModel.fromJson(jsonAffirmations);
  } else {
    throw Exception('Failed');
  }
}

Future<Quote> fetchQuote() async {
  final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));

  if (response.statusCode == 200) {
    return Quote.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load Quote');
  }
}

class _homePageState extends State<homePage> {
  List<bool> _goalChecklist = [false, false, false];
  List<String> _goalsList = ["", "", ""];
  ApiHelper apiHelper = ApiHelper();
  String jokeString = "";
  late Future<AffirmationsModel> _futureAffirmationsModel;
  late Future<Quote> quote;

  void initState() {
    super.initState();
    getJoke();
    _futureAffirmationsModel = fetchAffirmations();
    quote = fetchQuote();
  }

  Future<String?> openDialog(int goalIndex) => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Your Goal',
            style: TextStyle(fontFamily: 'SourceSans'),
          ),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Please enter your goal'),
            style: TextStyle(fontFamily: 'SourceSans'),
            onChanged: (value) {
              _goalsList[goalIndex] = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _goalsList[goalIndex] = _goalsList[goalIndex];
                });
                Navigator.pop(context);
              },
              child: const Text(
                'SUBMIT',
                style: TextStyle(fontFamily: 'SourceSans'),
              ),
            ),
          ],
        ),
      );

  void openAlert() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Error: Goals list full',
            style: TextStyle(fontFamily: 'SourceSans'),
          ),
          content: const Text(
            'Please delete one of your goals to add another one, by swiping left on the goal.',
            style: TextStyle(fontFamily: 'SourceSans'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(fontFamily: 'SourceSans'),
              ),
            ),
          ],
        ),
      );

  void getJoke() async {
    await apiHelper.getDadJoke().then((value) => {
          setState(() {
            jokeString = value;
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Home',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SourceSans',
                fontSize: 35.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'SourceSans',
                    ),
                    enabled: false,
                    decoration: kGoalsFieldDecoration,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (_goalsList[0] == '') {
                      final goal = await openDialog(0);
                    } else if (_goalsList[1] == '') {
                      final goal = await openDialog(1);
                    } else if (_goalsList[2] == '') {
                      final goal = await openDialog(2);
                    } else {
                      openAlert();
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xFFA686C7),
                    size: 35.0,
                  ),
                ),
                const SizedBox(
                  width: 50.0,
                ),
              ],
            ),
            Text(
              '  Please slide left to dismiss goal!',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SourceSans',
                fontSize: 15.0,
              ),
            ),
            Dismissible(
              key: const ValueKey('0'),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.redAccent,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30.0,
                ),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
              ),
              confirmDismiss: (direction) {
                if (_goalsList[0] == '') {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Invalid"),
                      content: Text("You are deleting an empty cell!"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text("Ok"),
                        ),
                      ],
                    ),
                  );
                } else {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Please Confirm"),
                      content: Text("Are you sure you want to delete?"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          },
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  );
                }
              },
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  setState(() {
                    _goalsList[0] = "";
                  });
                }
              },
              child: CheckboxListTile(
                value: _goalChecklist[0],
                title: Text(_goalsList[0]),
                activeColor: Colors.transparent,
                controlAffinity: ListTileControlAffinity.leading,
                checkColor: Color(0xFFA686C7),
                onChanged: (bool? value) {
                  setState(() {
                    _goalChecklist[0] = value!;
                  });
                },
              ),
            ),
            Dismissible(
              key: const ValueKey('1'),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.redAccent,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30.0,
                ),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
              ),
              confirmDismiss: (direction) {
                if (_goalsList[1] == '') {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Invalid"),
                      content: Text("You are deleting an empty cell!"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text("Ok"),
                        ),
                      ],
                    ),
                  );
                } else {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Please Confirm"),
                      content: Text("Are you sure you want to delete?"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          },
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  );
                }
              },
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  setState(() {
                    _goalsList[1] = "";
                  });
                }
              },
              child: CheckboxListTile(
                value: _goalChecklist[1],
                title: Text(_goalsList[1]),
                activeColor: Colors.transparent,
                controlAffinity: ListTileControlAffinity.leading,
                checkColor: Color(0xFFA686C7),
                onChanged: (bool? value) {
                  setState(() {
                    _goalChecklist[1] = value!;
                  });
                },
              ),
            ),
            Dismissible(
              key: const ValueKey('3'),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.redAccent,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30.0,
                ),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
              ),
              confirmDismiss: (direction) {
                if (_goalsList[2] == '') {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Invalid"),
                      content: Text("You are deleting an empty cell!"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text("Ok"),
                        ),
                      ],
                    ),
                  );
                } else {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Please Confirm"),
                      content: Text("Are you sure you want to delete?"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          },
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  );
                }
              },
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  setState(() {
                    _goalsList[2] = "";
                  });
                }
              },
              child: CheckboxListTile(
                value: _goalChecklist[2],
                title: Text(_goalsList[2]),
                activeColor: Colors.transparent,
                controlAffinity: ListTileControlAffinity.leading,
                checkColor: Color(0xFFA686C7),
                onChanged: (bool? value) {
                  setState(() {
                    _goalChecklist[2] = value!;
                  });
                },
              ),
            ),
            Column(
              children: <Widget>[
                Bubble(
                  elevation: 8.0,
                  color: Color(0xFF2FA9C0),
                  padding: BubbleEdges.all(10),
                  style: blueHomeBubble,
                  alignment: Alignment.topRight,
                  child: Text(
                    'Daily Laughs\n$jokeString',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SourceSans',
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Bubble(
                  elevation: 8.0,
                  color: Color(0xFF78BA7D),
                  padding: BubbleEdges.all(10),
                  style: greenHomeBubble,
                  child: FutureBuilder<AffirmationsModel>(
                    future: _futureAffirmationsModel,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Text(
                          'Daily Affirmation\n'
                          '${snapshot.data?.affirmation}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SourceSans',
                            fontSize: 20.0,
                          ),
                        );
                      } else {
                        return Text(
                          "${snapshot.error}",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SourceSans',
                            fontSize: 20.0,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Bubble(
                  color: Color(0xFF2FA9C0),
                  elevation: 8.0,
                  padding: BubbleEdges.all(10),
                  style: blueHomeBubble,
                  child: const Text(
                    'Compliment a stranger!',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SourceSans',
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: SizedBox(
                height: 10.0,
              ),
            ),
            const Center(
              child: Text(
                'Quote of the day',
                style: TextStyle(
                  color: Color(0xFFCF726A),
                  fontFamily: 'SourceSans',
                  fontSize: 15.0,
                ),
              ),
            ),
            FutureBuilder<Quote>(
              future: quote,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Bubble(
                    alignment: Alignment.center,
                    color: Color(0xFFCF726A),
                    elevation: 8.0,
                    padding: BubbleEdges.all(10),
                    style: redHomeBubble,
                    child: Center(
                      child: Text(
                        snapshot.data!.quoteText['q'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'SourceSans',
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Text("${snapshot.error}");
                }
              },
            ),
            const Center(
              child: Text(
                'If you ever need help or someone to talk to call 1-800-273-TALK (8255) or text MHA to 741741',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SourceSans',
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
