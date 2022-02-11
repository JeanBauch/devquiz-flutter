import 'package:DevQuiz/core/core.dart';
import 'package:DevQuiz/home/home_state.dart';
import 'package:DevQuiz/shared/models/awnser_models.dart';
import 'package:DevQuiz/shared/models/question_models.dart';
import 'package:DevQuiz/shared/models/quiz_models.dart';
import 'package:flutter/foundation.dart';
import '../shared/models/user_model.dart';

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  UserModel? user;
  List<QuizModel>? quizzes;

  void getUser() async{
    state = HomeState.loading;
    await Future.delayed(Duration(seconds: 2));
    user = UserModel(name: "Jean", photoUrl: "https://avatars.githubusercontent.com/u/61170558?v=4");
    state = HomeState.success;
  }

  void getQuizzes() async{
    state = HomeState.loading;
    await Future.delayed(Duration(seconds: 2));
    quizzes = [
      QuizModel(
        title: "Trilha de flutter",
        questionAnswered: 1,
        questions: [
          QuestionModel(
            title: "Isso é Flutter?",
            awnsers: [
              AwnserModel(title: "Claro que é", isRight: true),
              AwnserModel(title: "Não, isso é o react native"),
              AwnserModel(title: "Não isso é WEB"),
              AwnserModel(title: "Não, isso é ionic"),
            ]
          ),
          QuestionModel(
            title: "Isso é Flutter?",
            awnsers: [
              AwnserModel(title: "Claro que é", isRight: true),
              AwnserModel(title: "Não, isso é o react native"),
              AwnserModel(title: "Não isso é WEB"),
              AwnserModel(title: "Não, isso é ionic"),
            ]
          ),
        ], 
        imagem: AppImages.blocks,
        level: Level.facil
      )
    ];
    state = HomeState.success;
  }
}