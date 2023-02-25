import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:ncc/constants.dart';
import 'package:ncc/helpers/api-helper.dart';
import 'package:ncc/helpers/affirmations-helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ncc/helpers/quote.dart';

import '../helpers/goal.dart';
import '../helpers/color-goals.dart';
import '../helpers/goals-helper.dart';

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
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  late Future<JokesModel> _futureJokesModel;
  late Future<AffirmationsModel> _futureAffirmationsModel;
  late Future<Quote> quote;
  final _todoController = TextEditingController();

  void initState() {
    super.initState();
    _foundToDo = todosList;
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
                Bubble(
                    elevation: 8.0,
                    color: Color(0xFFA686C7),
                    padding: BubbleEdges.all(10),
                    style: greenHomeBubble,
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Short-term Goals',
                      style: TextStyle(
                        color: (Colors.white),
                        fontFamily: 'SourceSans',
                        fontSize: 20.0,
                      ),
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Row(children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 5,
                        right: 20,
                        left: 20,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                            hintText: 'Add a new todo item',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 5,
                      right: 20,
                    ),
                    child: ElevatedButton(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      ),
                      onPressed: () {
                        _addToDoItem(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: tdPurple,
                        minimumSize: Size(40, 45),
                        elevation: 10,
                      ),
                    ),
                  ),
                ]),
                Column(
                  children: [
                    SingleChildScrollView(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (ToDo todoo in _foundToDo.reversed)
                            ToDoItem(
                              todo: todoo,
                              onToDoChanged: _handleToDoChange,
                              onDeleteItem: _deleteToDoItem,
                            ),
                        ],
                      ),
                    )
                  ],
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

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }
}
