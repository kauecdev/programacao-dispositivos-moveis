import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizz_app/question_answer_enum.dart';

class Question {
  late String question;
  late QuestionAnswerEnum answer;

  Question(this.question, this.answer);

  Question.fromMap(Map map)
      : question = map["question"],
        answer = QuestionAnswerEnum.values.firstWhere((element) => element.name == map["answer"]);
}