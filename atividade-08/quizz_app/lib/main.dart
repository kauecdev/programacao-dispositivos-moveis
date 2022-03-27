import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/question_answer_enum.dart';
import 'package:quizz_app/question_manager.dart';

QuestionManager questionManager = QuestionManager();

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF1CB4DB),
        body: Techiz(),
      ),
    ),
  );
}

class Techiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TechizPage(),
      ),
    );
  }
}

class TechizPage extends StatefulWidget {
  @override
  State<TechizPage> createState() => _TechizPageState();
}

class _TechizPageState extends State<TechizPage> {
  List<Container> scoreKeeper = [];

  void checkAnswer(QuestionAnswerEnum userPickedAnswer) {
    QuestionAnswerEnum correctAnswer = questionManager.getCorrectAnswer();

    setState(() {
      if (questionManager.isFinished()) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('Finished!'),
                  content: const Text("You've completed the quiz!"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ]
              );
            }
        );
        questionManager.reset();
        scoreKeeper.clear();
      } else {
        if (userPickedAnswer == correctAnswer && userPickedAnswer == QuestionAnswerEnum.fact) {
          scoreKeeper.add(
            Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            )
          );
        } else if (correctAnswer == QuestionAnswerEnum.maybe) {
          scoreKeeper.add(
              Container(
                margin: const EdgeInsets.only(right: 4),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: const Icon(
                  CupertinoIcons.question,
                  color: Colors.orange,
                ),
              )
          );
        } else {
          scoreKeeper.add(
              Container(
                margin: const EdgeInsets.only(right: 4),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              )
          );
        }
        questionManager.getNextQuestion();
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: buildText(questionManager.getQuestion(), 25),
            ),
          ),
        ),
        buildButton('True', Colors.green, checkAnswer, QuestionAnswerEnum.fact),
        buildButton('False', Colors.red, checkAnswer, QuestionAnswerEnum.fake),
        buildButton('Maybe', const Color(0xFFFF6409), checkAnswer, QuestionAnswerEnum.maybe),
        Container(
          padding: scoreKeeper.isEmpty ? const EdgeInsets.all(18) : EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: scoreKeeper,
            )
          )
        )
      ],
    );
  }
}

Text buildText(String text, double fontSize, { FontWeight? fontWeight, Color? color }) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: 'Signika',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? Colors.white,
    )
  );
}

Expanded buildButton(String text, Color buttonColor, void Function(QuestionAnswerEnum) onPressed, QuestionAnswerEnum alternative) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
        ),
        onPressed: () {
          onPressed(alternative);
        },
        child: buildText(text, 24),
      ),
    ),
  );
}
