import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class page1 extends StatefulWidget {
  const page1({Key? key}) : super(key: key);

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: Lottie.asset("animation/animatoin2.json"),
        ),
      ),
    );
  }
}
