import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../myhomepage.dart';

class page3 extends StatefulWidget {
  static SharedPreferences? prefrs;

  @override
  State<page3> createState() => _page1State();
}
class _page1State extends State<page3> {
  bool loginstatus =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Splachscreen();
  }
  Future<void> Splachscreen() async {

     page3.prefrs = await SharedPreferences.getInstance();
    setState(() {
      loginstatus=page3.prefrs!.getBool("loginstatus")??false;
      print("${loginstatus}");
    });
     Future.delayed(Duration(seconds: 5)).then((value) {

        print("============$loginstatus");
      if(loginstatus){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return MyHOmepage();
        },));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return login();
        },));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Container(
        height: 300,
        width: 300,
        child: Lottie.asset("animation/animation1.json"),
      ),
    ),);
  }

}
