import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/question_answer_enum.dart';
import 'package:quizz_app/question_manager.dart';

QuestionManager questionManager = QuestionManager();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  List<QuestionAnswerEnum> scoreKeeper = [];

  Future<int> calcCorrectAnswersPercentage() async {
    int totalQuestionsAnsweredCorrect = scoreKeeper.where((score) => score == QuestionAnswerEnum.fact).length;
    int totalQuestionsFact = await questionManager.getTotalQuestionsFact();
   return ((totalQuestionsAnsweredCorrect * 100) / totalQuestionsFact).round();
  }

  void checkAnswer(QuestionAnswerEnum userPickedAnswer) async {
    QuestionAnswerEnum correctAnswer = await questionManager.getCorrectAnswer();

    bool isFinished = await questionManager.isFinished();

    int correctAnswersPercentage = await calcCorrectAnswersPercentage();

    setState(() {
      questionManager.getQuestionList();

      if (isFinished) {
        final snackBar = SnackBar(
            content: Text("You've completed the quiz and answered $correctAnswersPercentage% correct!"),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                // Some code to undo the change.
              },
            )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        questionManager.reset();
        scoreKeeper.clear();
      } else {
        if (userPickedAnswer == correctAnswer && userPickedAnswer == QuestionAnswerEnum.fact) {
          scoreKeeper.add(
            QuestionAnswerEnum.fact
          );
        } else if (correctAnswer == QuestionAnswerEnum.maybe) {
          scoreKeeper.add(
              QuestionAnswerEnum.maybe
          );
        } else {
          scoreKeeper.add(
              QuestionAnswerEnum.fake
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
              child: FutureBuilder<String>(
                future: questionManager.getQuestion(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    String? question = snapshot.data;
                    return buildText(question!, 25);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
        buildButton('True', Colors.green, checkAnswer, QuestionAnswerEnum.fact),
        buildButton('False', Colors.red, checkAnswer, QuestionAnswerEnum.fake),
        buildButton('Maybe', const Color(0xFFFF6409), checkAnswer, QuestionAnswerEnum.maybe),
        Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<int>(
            future: questionManager.getAnsweredPercentage(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                int? answeredPercentage = snapshot.data;
                return buildText('$answeredPercentage%'!, 18);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
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
