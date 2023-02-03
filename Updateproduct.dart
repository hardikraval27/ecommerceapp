import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecommerceapp/view_product.dart';
import 'package:http/http.dart' as http;

import 'myhomepage.dart';

class editproduct extends StatefulWidget {

  Productdata productdata;
  editproduct(this.productdata);

  @override
  State<editproduct> createState() => _editproductState();
}
class _editproductState extends State<editproduct> {

 String image="";
 String uid="";
 int a =0 ;

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
  void initState() {
    // TODO: implement initState
    super.initState();
  PMrp.text=widget.productdata.pRODUCTMRP!;
  Pd.text=widget.productdata.pRODUCTDESCRIPTION!;
  psp.text=widget.productdata.pRODUCTSELLINGPRICE!;
  ps.text=widget.productdata.pRODUCTSTOCK!;
  pn.text=widget.productdata.pRODUCTNAME!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      a=1;
                    });
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
                  child:a==1
                  ?Container(
                    child: CircleAvatar(
                      backgroundImage: FileImage(File(image,)),
                    ),
                    height: 160,
                    width: 160,
                    margin: const EdgeInsets.only(top: 15),
                  ):Container(child: CircleAvatar(backgroundImage: NetworkImage("https://hardik027.000webhostapp.com/Apicalling/${widget.productdata.iMAGEPRODUCT}"),
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

                        EasyLoading.showSuccess('Update Success!');
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
                          String imagedata="";

                          if(image!=""){
                            List<int> iii = File(image).readAsBytesSync();
                             imagedata = base64Encode(iii);
                          }

                          String? kk = widget.productdata.iMAGEPRODUCT;

                          Map pp = {
                            "myid": widget.productdata.iD,
                            "productname": PRODUCTNAME,
                            "productsellingprice": PRODUCTSELLINGPRICE,
                            "productmrp": PRODUCTMRP,
                            "productdescription": PRODUCTDECRIPTION,
                            "productstock": PRODUCTSTOCK,
                            "userid":uid,
                            "imageproduct": imagedata,
                            "imagedata":kk,
                          };
                          print("=================$pp");

                          var url = Uri.parse('https://hardik027.000webhostapp.com/Apicalling/Updatedata.php');
                          var response = await http.post(url, body: pp);
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');

                          var xx = jsonDecode(response.body);
                          update11 ww=update11.fromJson(xx);

                          if (ww.connection == 1) {
                            if (ww.result == 1) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return MyHOmepage();
                              },));
                            }
                          }
                        } EasyLoading.dismiss();
                      },
                      child: Text("Update"))
                ],
              ),
            ],
          ),
        )

    );
  }
}
class update11 {
  int? connection;
  int? result;

  update11({this.connection, this.result});

  update11.fromJson(Map<String, dynamic> json) {
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

