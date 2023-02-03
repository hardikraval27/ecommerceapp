import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class page2 extends StatefulWidget {
  const page2({Key? key}) : super(key: key);

  @override
  State<page2> createState() => _page1State();
}

class _page1State extends State<page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: Lottie.asset("animation/animation3.json"),
        ),
      ),
    );
  }
}
