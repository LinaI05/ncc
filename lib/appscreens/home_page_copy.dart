import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:ncc/constants.dart';
import 'package:ncc/helpers/api-helper.dart';
import 'package:ncc/helpers/affirmations-helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ncc/helpers/quote.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/color-goals.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

Future<JokesModel> fetchRandomJoke() async {
  final response = await http
      .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
  if (response.statusCode == 200) {
    final jsonJokes = jsonDecode(response.body);
    return JokesModel.fromJson(jsonJokes);
  } else {
    throw Exception('Failed');
  }
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
  List<bool> checkboxValues = List<bool>.generate(10, (index) => false);
  String input = "";

  createTodos() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTodos").doc(input);

    //Map
    Map<String, String> todos = {"todoTitle": input};
    documentReference.set(todos).whenComplete(() {
      print("$input created");
    });
  }

  deleteTodos(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTodos").doc(item);

    documentReference.delete().whenComplete(() {
      print("$item deleted");
    });
  }

  late Future<JokesModel> _futureJokesModel;
  late Future<AffirmationsModel> _futureAffirmationsModel;
  late Future<Quote> quote;

  @override
  void initState() {
    super.initState();
    _futureJokesModel = fetchRandomJoke();
    _futureAffirmationsModel = fetchAffirmations();
    quote = fetchQuote();
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
            Column(
              children: <Widget>[
                Row(children: [
                  Bubble(
                      elevation: 8.0,
                      color: Color(0xFFA686C7),
                      padding: BubbleEdges.all(12),
                      style: shortHomeBubble,
                      alignment: Alignment.center,
                      child: Text(
                        'Short-term Goals',
                        style: TextStyle(
                          color: (Colors.white),
                          fontFamily: 'SourceSans',
                          fontSize: 22.0,
                        ),
                      )),
                  const SizedBox(
                    width: 10.0,
                  ),
                  ElevatedButton(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '+',
                        style: TextStyle(
                          color: (Colors.white),
                          fontFamily: 'SourceSans',
                          fontSize: 32,
                        ),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                title: Text("Add Short-term Goal"),
                                insetPadding: EdgeInsets.zero,
                                content: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: tdPurple, width: 5.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: tdPurple)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: tdPurple))),
                                  onChanged: (String value) {
                                    input = value;
                                  },
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  tdPurple)),
                                      onPressed: () {
                                        // setState((){
                                        //   todos.add(input);
                                        // });
                                        createTodos();
                                        Navigator.of(context)
                                            .pop(); // closes the dialog
                                      },
                                      child: Text("Add"))
                                ]);
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: tdPurple,
                      minimumSize: Size(40, 45),
                      elevation: 8,
                    ),
                  ),
                ]),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("MyTodos")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Text('Loading'));
                      }
                      return StatefulBuilder(builder: (context, innerState) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot documentSnapshot =
                                  snapshot.data!.docs[index];
                              return Dismissible(
                                  onDismissed: (direction) {
                                    deleteTodos(documentSnapshot["todoTitle"]);
                                  },
                                  key: Key(documentSnapshot["todoTitle"]),
                                  child: Card(
                                      elevation: 4,
                                      margin:
                                          EdgeInsets.fromLTRB(2, 10, 17, 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: CheckboxListTile(
                                          activeColor: tdPurple,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(0, 7, 0, 7),
                                          value: checkboxValues[index],
                                          onChanged: (value) {
                                            innerState(
                                              () {
                                                checkboxValues[index] = value!;
                                              },
                                            );
                                          },
                                          title: Text(
                                              documentSnapshot["todoTitle"]),
                                          secondary: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: tdPurple,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                deleteTodos(documentSnapshot[
                                                    "todoTitle"]);
                                              });
                                            },
                                          ))));
                            });
                      });
                    }),
                const SizedBox(
                  height: 17.0,
                ),
                Column(
                  children: <Widget>[
                    Bubble(
                      elevation: 8.0,
                      color: Color(0xFF2FA9C0),
                      padding: BubbleEdges.all(10),
                      style: blueHomeBubble,
                      alignment: Alignment.topRight,
                      child: FutureBuilder<JokesModel>(
                        future: _futureJokesModel,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return Text(
                              'Daily Laughs\n'
                              '${snapshot.data?.joke}',
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
                      height: 15.0,
                    ),
                    Bubble(
                      elevation: 8.0,
                      color: Color(0xFF78BA7D),
                      padding: BubbleEdges.all(10),
                      style: greenHomeBubble,
                      child: FutureBuilder<AffirmationsModel>(
                        future: _futureAffirmationsModel,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
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
                      height: 15.0,
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
                    height: 15.0,
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
          ],
        ),
      ),
    );
  }
}
