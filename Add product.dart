import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:myecommerceapp/intro_screen/intro_page_3.dart';
import 'package:myecommerceapp/myhomepage.dart';


class Addproduct extends StatefulWidget {
  const Addproduct({Key? key}) : super(key: key);

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  String image = "";

  TextEditingController psp = TextEditingController();
  TextEditingController PMrp = TextEditingController();
  TextEditingController Pd = TextEditingController();
  TextEditingController ps = TextEditingController();
  TextEditingController pn = TextEditingController();

  bool rr1= true;
  bool rr2= true;
  bool rr3 = true;
  bool rr4 = true;
  bool rr5 = true;
  bool rr6 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
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
                            final XFile? abc = await _picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              image = abc!.path;
                            });
                          },
                          child: const Icon(Icons.image)),
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            final ImagePicker _picker = ImagePicker();
                            final XFile? abc = await _picker.pickImage(
                                source: ImageSource.camera);
                            setState(() {
                              image = abc!.path;
                            });
                          },
                          child: const Icon(Icons.camera_alt_outlined)),
                    ],
                  );
                },
              );
            },
            child:image!=""?
            Container(
              child: CircleAvatar(
                backgroundImage: FileImage(File(image)),
              ),
              height: 160,
              width: 160,
              margin: const EdgeInsets.only(top: 15),
            ):Container(child: CircleAvatar(backgroundColor: Colors.lightGreenAccent,
              backgroundImage: FileImage(File(image)),
            ),
              height: 160,
              width: 160,
              margin: const EdgeInsets.only(top: 15),)
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  controller: pn,
                  decoration: InputDecoration(
                      errorText: rr1 ? null : "product name",
                      hintText: "product name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onChanged: (value) {
                    if (value!="") {
                      setState(() {
                        rr1 = true;
                      });
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  controller: psp,
                  decoration: InputDecoration(
                      errorText:rr2 ? null : "product name",
                      hintText: "Product Selling Price",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onChanged: (value) {
                    if (value!="") {
                      setState(() {
                        rr2 = true;
                      });
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  controller: PMrp,
                  decoration: InputDecoration(
                      errorText: rr3 ? null : "product name",
                      hintText: "Product MRP",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onChanged: (value) {
                    if (value!="") {
                      setState(() {
                        rr3 = true;
                      });
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  controller: Pd,
                  decoration: InputDecoration(
                      errorText: rr4 ? null : "product name",
                      hintText: "Product Description ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onChanged: (value) {
                    if (value!="") {
                      setState(() {
                        rr4 = true;
                      });
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  controller: ps,
                  decoration: InputDecoration(
                      errorText: rr5 ? null : "product name",
                      hintText: "Product Stock",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onChanged: (value) {
                    if (value!="") {
                      setState(() {
                        rr5 = true;
                      });
                    }
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    String? USERID = page3.prefrs!.getString("myid");
                    String PRODUCTNAME = pn.text;
                    String PRODUCTSELLINGPRICE = psp.text;
                    String PRODUCTMRP = PMrp.text;
                    String PRODUCTDECRIPTION = Pd.text;
                    String PRODUCTSTOCK = ps.text;

                    if (pn.text=="") {
                      setState(() {
                        rr1 = false;
                      });
                    } else if (psp.text=="") {
                      setState(() {
                        rr2 = false;
                      });
                    } else if (PMrp.text=="") {
                      setState(() {
                        rr3 = false;
                      });
                    } else if (Pd.text=="") {
                      setState(() {
                        rr4 = false;
                      });
                    } else if (ps.text=="") {
                      setState(() {
                        rr5 = false;
                      });
                    } else {

                      List<int> iii = File(image).readAsBytesSync();
                      String imagedata = base64Encode(iii);

                      Map hh = {
                        "userid": USERID,
                        "productname": PRODUCTNAME,
                        "productsellingprice": PRODUCTSELLINGPRICE,
                        "productmrp": PRODUCTMRP,
                        "productdescription": PRODUCTDECRIPTION,
                        "productstock": PRODUCTSTOCK,
                        "imageproduct": imagedata
                      };
                      print("=================$hh");
                      var url = Uri.parse('https://hardik027.000webhostapp.com/Apicalling/addproduct.php');
                      var response = await http.post(url, body: hh);
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');

                      var nn = jsonDecode(response.body);
                      myproduct dd = myproduct.fromJson(nn);

                      if (dd.connection == 1) {
                        if (dd.result == 1) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return MyHOmepage();
                          },));
                        }
                      }
                    }
                  },
                  child: Text("Submit"))
            ],
          ),
        ],
      ),
    ));
  }
}
class myproduct {
  int? connection;
  int? result;

  myproduct({this.connection, this.result});

  myproduct.fromJson(Map<String, dynamic> json) {
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
