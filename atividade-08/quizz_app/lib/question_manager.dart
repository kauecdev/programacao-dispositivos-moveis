import 'package:quizz_app/question.dart';
import 'package:quizz_app/question_answer_enum.dart';

class QuestionManager {

  int _questionNumber = 0;

  final List<Question> _questionList = [
    Question("The cryptocurrency transactions happens in the blockchain?", QuestionAnswerEnum.fact),
    Question("Python is a programming language?", QuestionAnswerEnum.fact),
    Question("Can computer viruses infect humans?", QuestionAnswerEnum.fake),
    Question("Technology will someday reach the limit of evolution?", QuestionAnswerEnum.maybe),
    Question("Can computer viruses infect humans?", QuestionAnswerEnum.maybe),
    Question("Can computer viruses infect humans?", QuestionAnswerEnum.maybe),
    Question("Can computer viruses infect humans?", QuestionAnswerEnum.maybe),
  ];

  void getNextQuestion() {
    if (_questionNumber < _questionList.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestion() {
    return _questionList[_questionNumber].question;
  }

  QuestionAnswerEnum getCorrectAnswer() {
    return _questionList[_questionNumber].answer;
  }

  bool isFinished() {
    return _questionNumber >= _questionList.length - 1 ? true : false;
  }

  void reset() {
    _questionNumber = 0;
  }
}