import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class registerpage extends StatefulWidget {
  const registerpage({Key? key}) : super(key: key);

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  bool sn = false;

  TextEditingController name1 = TextEditingController();
  TextEditingController Email2 = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController password2 = TextEditingController();

  String image="";

  bool securetext = true; //***

// Initial Selected Value
  String dropdownvalue = '10th';

// List of items in our dropdown menu
  List<String> items = [
    '10th',
    '12th',
    'b.com',
    'm.com',
  ];

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/lp.jpg"), fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // backgroundColor: Color(0xFFBF9958),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Column(
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  final ImagePicker _picker = ImagePicker();
                                 // Pick an image
                                  final XFile? abc = await _picker.pickImage(source: ImageSource.gallery);
                                  setState(() {
                                    image=abc!.path;
                                  });
                                },
                                child: const Icon(Icons.image)),
                            ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  final ImagePicker _picker = ImagePicker();
                                  // Pick an image
                                  final XFile? abc = await _picker.pickImage(source: ImageSource.camera);
                                  setState(() {
                                    image=abc!.path;
                                  });
                                },
                                child: const Icon(Icons.camera_alt_outlined)),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(child: CircleAvatar(backgroundImage: FileImage(File(image)),),
                    height: 160,
                    width: 160,
                    margin: const EdgeInsets.only(top: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: TextField(
                    controller: name1,
                    decoration: InputDecoration(
                        errorText: sn ? "name" : null,
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Name",
                        icon: Icon(Icons.edit),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          sn = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, right: 30, left: 30),
                  child: TextField(
                    controller: Email2,
                    decoration: InputDecoration(
                      errorText: sn ? "email" : null,
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Email",
                      icon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          sn = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 30, left: 30),
                  child: TextField(
                    controller: dateInput,
                    decoration: InputDecoration(
                      errorText: sn ? "date of birth" : null,
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Date of birth",
                      icon: const Icon(Icons.date_range),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          sn = false;
                        });
                      }
                    },
                    //  readOnly: true,
                    // set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 25),
                      child: const Icon(Icons.star),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 60,
                      width: 290,
                      margin:
                          const EdgeInsets.only(top: 10, right: 20, left: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 30, left: 30),
                  child: TextField(
                    controller: password2,
                    obscureText: securetext,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      errorText: sn ? "password" : null,
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          securetext= !securetext;
                        });
                      }, icon:Icon(Icons.remove_red_eye_outlined),),
                      labelText: "Password",
                      icon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          sn = false;
                        });
                      }
                    },
                    toolbarOptions: const ToolbarOptions(
                        copy: false,
                        cut: false,
                        paste: false,
                        selectAll: false),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                      onPressed: () async {
                        String NAME = name1.text;
                        String Email = Email2.text;
                        String DATE = dateInput.text;
                        String PASSWORD = password2.text;

                        List<int> iii=File(image).readAsBytesSync();
                        String imagedata=base64Encode(iii);

                        Map vv = {
                          "name": NAME,
                          "email": Email,
                          "date": DATE,
                          "password": PASSWORD,
                          "imagedata":imagedata
                        };
                        var url = Uri.parse('https://hardik027.000webhostapp.com/Apicalling/hardik27.php');
                        var response = await http.post(url, body: vv);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');

                        var rr= jsonDecode(response.body);

                        Myregister uu= Myregister.fromJson(rr);

                        if(uu.connection==1)
                          {
                            if(uu.result==1)
                              {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Register Successfully")));
                              }
                            else if(uu.result==2)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Already Exit")));
                              }
                          }
                        sn = false;
                        if (NAME.isEmpty) {
                          sn = true;
                        } else if (Email.isEmpty) {
                          sn = true;
                        } else if (DATE.isEmpty) {
                          sn = true;
                        } else if (PASSWORD.isEmpty) {
                          sn = true;
                        }
                        else {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return login();
                                },
                              ));
                        }
                      },
                      child: const Text(
                        "SUBMIT",
                        style: TextStyle(color: Colors.red),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Myregister {
  int? connection;
  int? result;

  Myregister({this.connection, this.result});

  Myregister.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}

