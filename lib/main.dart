import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/introPage.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int question_index = 0;
  bool showScore = false;
  bool showIntro = true;
  int score = 0;
  String? selectedChoice;
  List<Map<String, dynamic>> QuestionsWithAnswers = [
    {
      'question': 'What is the first pillar of Islam?',
      'answers': ['Zakat', 'Salah', 'Hajj', 'Shahada'],
      'correct_answer': 'Shahada'
    },
    {
      'question': 'How many times a day are Muslims required to pray?',
      'answers': ['Three times', ' Four times', 'Fives times', 'Six times'],
      'correct_answer': 'Fives times'
    },
    {
      'question': 'Who is considered the final prophet in Islam?',
      'answers': ['Moses', 'Jesus', 'Muhammad', 'Abraham'],
      'correct_answer': 'Muhammad'
    },
    {
      'question': 'In which city was the Prophet Muhammad born?',
      'answers': ['Medina', 'Jerusalem', 'Mecca', 'Cairo'],
      'correct_answer': 'Mecca'
    },
    {
      'question': 'What does the term "Halal" mean',
      'answers': ['Forbidden', 'Allowed', 'Sacred', 'Unclean'],
      'correct_answer': 'Allowed'
    },
    {
      'question': 'What is the Arabic term for fasting?',
      'answers': ['Salah', 'Sawm', 'Hajj', 'Zakat'],
      'correct_answer': 'Sawm'
    },
  ];

  int _timeLeft = 15;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0)
          _timeLeft--;
        else if (_timeLeft == 0) {
          Vibration.vibrate(duration: 500);
          _endQuiz();
        }
      });
    });
  }

  void _endQuiz() {
    _timer.cancel();

    setState(() {
      showScore = true;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz App",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: showIntro
              ? IntroPage(onStartPressed: () {
                  setState(() {
                    showIntro = false;
                    _startTimer();
                  });
                })
              : Padding(
                  padding: const EdgeInsets.fromLTRB(8, 36, 8, 16),
                  child: !showScore
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                                QuestionsWithAnswers[question_index]
                                    ['question'],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Answer and get points !",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 19),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    width: _timeLeft <= 5 ? 2.5 : 1,
                                    color: _timeLeft <= 5
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _timeLeft > 9
                                      ? "00:${_timeLeft.toString()}"
                                      : "00:0${_timeLeft.toString()}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: _timeLeft <= 5
                                        ? FontWeight.w900
                                        : FontWeight.normal,
                                    color: _timeLeft <= 5
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: "Step ${question_index + 1} ",
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text:
                                                "of ${QuestionsWithAnswers.length}",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              color: Color.fromARGB(
                                                  255, 173, 168, 168),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    )),
                                    SizedBox(
                                      height: 5,
                                      child: LinearProgressIndicator(
                                        value: (question_index + 1) /
                                            QuestionsWithAnswers.length,
                                        backgroundColor: const Color.fromARGB(
                                            255, 232, 217, 217),
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // code of choices
                              Column(
                                children: (QuestionsWithAnswers[question_index]
                                        ['answers'] as List<String>)
                                    .map(
                                      (choice) => Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedChoice = choice;
                                            });
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(16),
                                            // decoration block
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.4)),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: choice == selectedChoice
                                                  ? Colors.green
                                                  : null,
                                            ),
                                            child: Row(children: [
                                              Icon(
                                                Icons.add,
                                                color: choice == selectedChoice
                                                    ? Colors.white
                                                    : null,
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                choice,
                                                style: TextStyle(
                                                    color:
                                                        choice == selectedChoice
                                                            ? Colors.white
                                                            : null),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              // space to the last
                              const Spacer(),
                              // code of 'Next' button
                              SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: Builder(builder: (context) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        if (selectedChoice != null) {
                                          if (selectedChoice ==
                                              QuestionsWithAnswers[
                                                      question_index]
                                                  ['correct_answer']) {
                                            setState(() {
                                              score++;
                                            });
                                          }
                                          if (question_index <
                                              QuestionsWithAnswers.length - 1) {
                                            setState(() {
                                              question_index++;
                                              selectedChoice = null;
                                            });
                                          } else {
                                            setState(() {
                                              showScore = true;
                                              selectedChoice = null;
                                              _timeLeft = -1;
                                            });
                                          }
                                        } else if (selectedChoice == null) {
                                          var snackBar = const SnackBar(
                                              content: Text(
                                                  "Please select your option!",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              duration: Duration(seconds: 2));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      child: const Text('Next'),
                                    );
                                  })),
                              const SizedBox(
                                height: 20,
                              )
                            ])
                      // Case 2 -the condition is false :
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ((QuestionsWithAnswers.length / 2) <= score)
                                    ? 'Congratulations !\n'
                                    : 'Game Over !\n',
                                style: TextStyle(
                                    color: ((QuestionsWithAnswers.length / 2) <=
                                            score)
                                        ? Color.fromARGB(255, 1, 197, 8)
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 33),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // using stack wiht circular bar and its text
                              Stack(alignment: Alignment.center, children: [
                                SizedBox(
                                  width: 160,
                                  height: 160,
                                  child: CircularProgressIndicator(
                                    color: ((QuestionsWithAnswers.length / 2) <=
                                            score)
                                        ? Colors.green
                                        : Colors.red,
                                    backgroundColor: const Color.fromARGB(
                                        255, 230, 217, 217),
                                    value: score / QuestionsWithAnswers.length,
                                    strokeWidth: 8.5,
                                  ),
                                ),
                                Text(
                                  '$score/${QuestionsWithAnswers.length}',
                                  style: TextStyle(
                                      color:
                                          ((QuestionsWithAnswers.length / 2) <=
                                                  score)
                                              ? Color.fromARGB(255, 1, 197, 8)
                                              : Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40),
                                ),
                              ]),
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                width: double.infinity,
                                height: 55,
                                margin:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 10),
                                //padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: ((QuestionsWithAnswers.length / 2) <=
                                          score)
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(
                                  //     color: Colors.green, width: 2)
                                ),

                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        question_index = 0;
                                        score = 0;
                                        showScore = false;
                                        selectedChoice = null;
                                        showIntro = true;
                                        _timer.cancel();
                                        _timeLeft = 15;
                                        //_startTimer();
                                      });
                                    },
                                    // last buttons
                                    child: Center(
                                      child: Text(
                                        ((QuestionsWithAnswers.length / 2) <=
                                                score)
                                            ? "Restart"
                                            : 'Try Again',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                              Container(
                                width: double.infinity,
                                height: 55,
                                margin:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                //padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: ((QuestionsWithAnswers.length / 2) <=
                                          score)
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  // border:
                                  //     Border.all(color: Colors.green, width: 2),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      SystemNavigator.pop();
                                    },
                                    child: Center(
                                      child: Text(
                                        "Exit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}
