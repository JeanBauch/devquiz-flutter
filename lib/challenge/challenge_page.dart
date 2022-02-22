import 'package:DevQuiz/challenge/challenge_controller.dart';
import 'package:DevQuiz/challenge/widget/next_button/next_button_widget.dart';
import 'package:DevQuiz/challenge/widget/question_indicator/question_indicator_widget.dart';
import 'package:DevQuiz/challenge/widget/quiz/quiz_widget.dart';
import 'package:DevQuiz/result/result_page.dart';
import 'package:DevQuiz/shared/models/question_models.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;
  const ChallengePage({ Key? key, required this.questions, required this.title }) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() { 
      controller.currentPage = pageController.page!.toInt() + 1; 
    });
    super.initState();
  }

  void nextPage(){
    if(controller.currentPage < widget.questions.length)
      pageController.nextPage(
        duration: Duration(seconds: 1),
        curve: Curves.ease
      ); 
  }

  void onSelected(bool value) {
    if(value) {
      controller.countAnwserRight++;
    }
    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86) , 
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),

              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifer, 
                builder: (context,value,_) => QuestionIndicatorWidget(
                  currentPage: value,
                  length: widget.questions.length,
                ),
              ),
            ],
          )
        ), 
      ),
      body: PageView(
        controller: pageController,
        children: widget.questions.map((e) => QuizWidget(question: e, onSelectd: onSelected,), ).toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ValueListenableBuilder<int>(
            valueListenable: controller.currentPageNotifer, 
            builder: (context, value, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if(value < widget.questions.length)
                  Expanded(
                    child: NextButtonWidget.white(
                      label: "Pular",
                      onTap: nextPage,
                    )
                  ),
                if(value == widget.questions.length)
                  Expanded(
                    child: NextButtonWidget.darkGreen(
                      label: "Confirmar",
                      onTap: () { 
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ResultPage(title: widget.title, length: widget.questions.length, result: controller.countAnwserRight,))
                        );
                      },
                    )
                  ),
              ],
            )
          )
        ),
      ),
    );
  }
}