import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'intro_screen/intro_page_1.dart';
import 'intro_screen/intro_page_2.dart';
import 'intro_screen/intro_page_3.dart';
import 'main.dart';
import 'myhomepage.dart';

class introduction extends StatefulWidget {


  const introduction({Key? key}) : super(key: key);

  @override
  State<introduction> createState() => _introductionState();
}
class _introductionState extends State<introduction> {
  PageController controller1 = PageController();

  bool onlastpage =false;

  bool loginstatus =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: controller1,
          onPageChanged: (index) {
            setState(() {
              onlastpage= (index ==2);
            });
          },
          children: [
            page1(),
            page2(),
            page3()
          ],
        ),
        Container(
            alignment: const Alignment(0,0.75),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(onTap: () {
                  controller1.jumpToPage(2);
                },
                    child: Text("skip")),
                SmoothPageIndicator(
                  controller: controller1,
                  count: 3,
                ),
                onlastpage?
                InkWell(onTap: () {
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                   return MyHOmepage();
                 },));
                },
                    child: Text("done")):
                GestureDetector(onTap: () {
                  controller1.nextPage(duration: Duration(microseconds: 500), curve: Curves.easeIn);
                },
                    child: Text("next")),
              ],
            )),
      ],
    ));
  }
}
