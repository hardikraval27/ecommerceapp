import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myecommerceapp/Buynow.dart';
import 'package:myecommerceapp/intro_screen/intro_page_3.dart';
import 'Updateproduct.dart';

class view_product extends StatefulWidget {
  @override
  State<view_product> createState() => _view_productState();
}
class _view_productState extends State<view_product> {
  String? USERID;

  String? image;

  showdata? bb;

  bool hh = false;

  deleteproduct? ll;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewdata();
  }
  Future<void> viewdata() async {
    String? USERID = page3.prefrs!.getString("myid") ?? "";

    Map pp = {
      "myid": USERID,
    };
    var url = Uri.parse('https://hardik027.000webhostapp.com/Apicalling/viewproduct.php');
    var response = await http.post(url, body: pp);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var yy = jsonDecode(response.body);
    bb = showdata.fromJson(yy);

    if (bb!.connection == 1) {
      if (bb!.result == 1) {
        setState(() {
          hh = true;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
            body: hh ?ListView.builder(
              itemCount: bb!.productdata!.length,
              itemBuilder: (context, index) {
                return Slidable(
                 startActionPane: ActionPane(motion: BehindMotion(), children: [
                    SlidableAction(
                      backgroundColor: Colors.lightGreenAccent,
                      icon: Icons.edit,
                      onPressed: (context) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return editproduct(bb!.productdata![index]);
                         },));
                      },
                    ),
                    SlidableAction(
                      backgroundColor: Colors.cyanAccent,
                      icon: Icons.delete,
                      onPressed: (context) async {

                        EasyLoading.showSuccess('Delete Success!');

                        String? hh = bb!.productdata![index].iD;
                        Map del={"myid":hh};

                        var url = Uri.parse('https://hardik027.000webhostapp.com/Apicalling/deletedata.php');
                        var response = await http.post(url, body: del);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');

                        var qq= jsonDecode(response.body.toString());
                         ll=deleteproduct.fromJson(qq);

                         if(ll!.connection==1){
                           if(ll!.result==1)
                             {
                                 viewdata();
                               //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("delete")));
                             }
                         }EasyLoading.dismiss();
                      },
                    ),
                  ]),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InkWell(onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return buy(bb!.productdata![index]);
                          },));
                        },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.blueGrey)),
                            child: Row(
                              children: [
                                Card(elevation: 10,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.20,
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1)),
                                      child: Image(image: NetworkImage("https://hardik027.000webhostapp.com/Apicalling/${bb!.productdata![index].iMAGEPRODUCT}"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Name:-\t${bb!.productdata![index].pRODUCTNAME}\n"
                                        "Price:-\t${bb!.productdata![index].pRODUCTSELLINGPRICE}\n"
                                        "Mrp:-\t${bb!.productdata![index].pRODUCTMRP}\n"
                                        "Description:-\t${bb!.productdata![index].pRODUCTDESCRIPTION}\n"
                                        "Stock:-\t${bb!.productdata![index].pRODUCTSTOCK}\n",
                                        style:
                                            TextStyle(color: Colors.deepOrange),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ): Center(child: CircularProgressIndicator()),
          );
  }
}

class showdata {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  showdata({this.connection, this.result, this.productdata});

  showdata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Productdata {
  String? iD;
  String? uSERID;
  String? pRODUCTNAME;
  String? pRODUCTSELLINGPRICE;
  String? pRODUCTMRP;
  String? pRODUCTDESCRIPTION;
  String? pRODUCTSTOCK;
  String? iMAGEPRODUCT;

  Productdata(
      {this.iD,
      this.uSERID,
      this.pRODUCTNAME,
      this.pRODUCTSELLINGPRICE,
      this.pRODUCTMRP,
      this.pRODUCTDESCRIPTION,
      this.pRODUCTSTOCK,
      this.iMAGEPRODUCT});

  Productdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    uSERID = json['USERID'];
    pRODUCTNAME = json['PRODUCT_NAME'];
    pRODUCTSELLINGPRICE = json['PRODUCT_SELLING_PRICE'];
    pRODUCTMRP = json['PRODUCT_MRP'];
    pRODUCTDESCRIPTION = json['PRODUCT_DESCRIPTION'];
    pRODUCTSTOCK = json['PRODUCT_STOCK'];
    iMAGEPRODUCT = json['IMAGEPRODUCT'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['USERID'] = this.uSERID;
    data['PRODUCT_NAME'] = this.pRODUCTNAME;
    data['PRODUCT_SELLING_PRICE'] = this.pRODUCTSELLINGPRICE;
    data['PRODUCT_MRP'] = this.pRODUCTMRP;
    data['PRODUCT_DESCRIPTION'] = this.pRODUCTDESCRIPTION;
    data['PRODUCT_STOCK'] = this.pRODUCTSTOCK;
    data['IMAGEPRODUCT'] = this.iMAGEPRODUCT;
    return data;
  }
}
class deleteproduct {
  int? connection;
  int? result;

  deleteproduct({this.connection, this.result});

  deleteproduct.fromJson(Map<String, dynamic> json) {
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

