import 'package:example/model/questionList.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'mainPage.dart'; //https://pub.dev/packages/smooth_page_indicator

class ToDayDiary extends StatefulWidget {
  const ToDayDiary({Key? key}) : super(key: key);

  @override
  State<ToDayDiary> createState() => _Diary();
}

class _Diary extends State<ToDayDiary> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  int length = QuestionList().questionList.length;

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        length + 1,
        (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Card(
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  height: 280,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Text(
                          index < length
                              ? QuestionList().questionList[index]
                              : "테스트가 끝났습니다!\n감사합니다",
                          style: const TextStyle(fontSize: 18),
                        ),
                      )),
                      const SizedBox(
                        height: 40,
                      ),
                      index < length
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (index <
                                        QuestionList().questionList.length) {
                                      setState(() {
                                        index++;
                                      });
                                      controller.animateToPage(
                                        index,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  child: const Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (index <
                                        QuestionList().questionList.length) {
                                      setState(() {
                                        index++;
                                      });
                                      controller.animateToPage(
                                        index,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffAFE0BD)),
                                  child: const Text(
                                    "No",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            )
                          : ElevatedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainPage()),
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              child: const Text(
                                "완료",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xff72D88F),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 130,),
            const Text(
              "오늘, 당신의 기분은 어떤가요?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 35),
            SizedBox(
              height: 240,
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: JumpingDotEffect(
                activeDotColor: Theme.of(context).colorScheme.primary,
                dotHeight: 16,
                dotWidth: 16,
                jumpScale: .7,
                verticalOffset: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
