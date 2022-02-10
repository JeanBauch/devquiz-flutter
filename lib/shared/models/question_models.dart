import 'package:DevQuiz/shared/models/awnser_models.dart';

class QuestionModel {
  final String title;
  final List<AwnserModel> awnsers;

  QuestionModel({
    required this.title, 
    required this.awnsers
  }): assert(awnsers.length == 4);
}