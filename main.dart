import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:myecommerceapp/intro_screen/intro_page_3.dart';
import 'package:myecommerceapp/registerpage.dart';
import 'introduction screen.dart';
import 'myhomepage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: introduction(),
      builder: EasyLoading.init(),
  ));
}

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool dd1 = false;
  bool dd2 = false;

  TextEditingController image1 = TextEditingController();
  TextEditingController password1 = TextEditingController();

  bool securetext = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/lp.jpg"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // backgroundColor: Color(0xFFBF9958),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 250, left: 20, right: 20),
              child: TextField(
                controller: image1,
                decoration: InputDecoration(
                    errorText: dd1 ? "uesr id" : null,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    labelText: "User ID",
                    labelStyle: const TextStyle(fontSize: 30),
                    icon: const Icon(
                      Icons.account_circle_sharp,
                      size: 30,
                    )),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      dd1 = false;
                    });
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: TextField(
                controller: password1,
                decoration: InputDecoration(
                    errorText: dd2 ? "password" : null,
                    fillColor: Colors.white,
                    filled: true,
                    //prefixIcon:Icon(Icons.remove_red_eye_outlined),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          securetext = !securetext;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye_outlined),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    labelText: "Password",
                    labelStyle: const TextStyle(fontSize: 30),
                    icon: const Icon(
                      Icons.lock,
                      size: 30,
                    )),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      dd1 = false;
                    });
                  }
                },
                toolbarOptions: const ToolbarOptions(
                    copy: false, cut: false, paste: false, selectAll: false),
                obscureText: securetext,
                obscuringCharacter: "*",
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                  onPressed: () async {
                    String EMAIL = image1.text;
                    String PSSWORD = password1.text;

                    Map mm = {"email": EMAIL, "password": PSSWORD};

                    var url = Uri.parse('https://hardik027.000webhostapp.com/Apicalling/login.php');
                    var response = await http.post(url, body: mm);
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    var mapp = jsonDecode(response.body);

                    Logindata tt = Logindata.fromJson(mapp);

                    if (tt.connection == 1) {
                      if (tt.result == 1) {

                        print("=====${tt.result}");

                        String? myid = tt.userdata!.id;
                        String? myname = tt.userdata!.nAME;
                        String? myemail = tt.userdata!.eMAIL;
                        String? mypassword = tt.userdata!.pASSWORD;
                        String? mydate = tt.userdata!.dATE;
                        String? myimage = tt.userdata!.image;
                        print(myid);

                        page3.prefrs!.setBool("loginstatus", true);

                        page3.prefrs!.setString("myid", myid!);
                        page3.prefrs!.setString("myname", myname!);
                        page3.prefrs!.setString("myemail", myemail!);
                        page3.prefrs!.setString("mypassword", mypassword!);
                        page3.prefrs!.setString("mydate", mydate!);
                        page3.prefrs!.setString("myimage", myimage!);

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return MyHOmepage();
                        },));
                      }
                    }
                    setState(() {
                      dd1 = false;
                      dd2 = false;

                      if (EMAIL.isEmpty) {
                        dd1 = true;
                      } else if (PSSWORD.isEmpty) {
                        dd2 = true;
                      } else {}
                    });
                  },
                  child: const Text("Login")),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return registerpage();
                  },
                ));
              },
              child: Container(
                margin: EdgeInsets.only(top: 40),
                child: RichText(text: const TextSpan(
                  text: "Don\'t have an account? ",
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text:" Sign Up",
                          style: TextStyle(
                          //    fontSize: 20
                          fontWeight: FontWeight.w700,
                            color: Colors.blue
                          )
                    )
                  ],
                ),

                ),
                // Text("Sign Up?",
                //     style: TextStyle(fontSize: 15, color: Colors.blue)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class Logindata {
  int? connection;
  int? result;
  Userdata? userdata;

  Logindata({this.connection, this.result, this.userdata});

  Logindata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? id;
  String? nAME;
  String? eMAIL;
  String? pASSWORD;
  String? dATE;
  String? image;

  Userdata(
      {this.id, this.nAME, this.eMAIL, this.pASSWORD, this.dATE, this.image});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nAME = json['NAME'];
    eMAIL = json['EMAIL'];
    pASSWORD = json['PASSWORD'];
    dATE = json['DATE'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['NAME'] = this.nAME;
    data['EMAIL'] = this.eMAIL;
    data['PASSWORD'] = this.pASSWORD;
    data['DATE'] = this.dATE;
    data['image'] = this.image;
    return data;
  }
}
