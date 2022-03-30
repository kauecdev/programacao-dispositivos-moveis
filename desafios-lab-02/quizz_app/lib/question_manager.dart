import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizz_app/question.dart';
import 'package:quizz_app/question_answer_enum.dart';

class QuestionManager {

  int _questionNumber = 0;

  Future<List<Question>> getQuestionList() async {
    final querySnapshot = await FirebaseFirestore.instance.collection("questions").get();

    final docs = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<Question> questions = docs.map((doc) => Question.fromMap(doc)).toList();

    return questions;
  }

  void getNextQuestion() async {
    List<Question> _questionList = await getQuestionList();
    if (_questionNumber < _questionList.length - 1) {
      _questionNumber++;
    }
  }

  Future<String> getQuestion() async {
    List<Question> _questionList = await getQuestionList();
    return _questionList[_questionNumber].question;
  }

  Future<QuestionAnswerEnum> getCorrectAnswer() async {
    List<Question> _questionList = await getQuestionList();
    return _questionList[_questionNumber].answer;
  }

  Future<bool> isFinished() async {
    List<Question> _questionList = await getQuestionList();
    return _questionNumber >= _questionList.length - 1 ? true : false;
  }

  void reset() {
    _questionNumber = 0;
  }

  Future<int> getAnsweredPercentage() async {
    List<Question> _questionList = await getQuestionList();
    return ((_questionNumber * 100) / _questionList.length).round();
  }

  Future<int> getTotalQuestionsFact() async {
    List<Question> _questionList = await getQuestionList();
    return _questionList.where((question) => question.answer == QuestionAnswerEnum.fact).length;
  }
}