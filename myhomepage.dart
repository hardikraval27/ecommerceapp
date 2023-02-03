import 'package:flutter/material.dart';
import 'package:myecommerceapp/intro_screen/intro_page_3.dart';
import 'package:myecommerceapp/main.dart';
import 'package:myecommerceapp/view_product.dart';

import 'Add product.dart';

class MyHOmepage extends StatefulWidget {
  const MyHOmepage({Key? key}) : super(key: key);

  @override
  State<MyHOmepage> createState() => _MyHOmepageState();
}

class _MyHOmepageState extends State<MyHOmepage> {
  String? name;
  String? email;
  String? imagepath;

  List<Widget> list = [Addproduct(), view_product()];
  List bb = ["Addproduct", "view_product"];



  int cnt = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = page3.prefrs!.getString("myname");
    email = page3.prefrs!.getString("myemail");
    imagepath = page3.prefrs!.getString("myimage");
    print("$imagepath");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bb[cnt]),
        centerTitle: true,
      ),
      body: list[cnt],
      drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://hardik027.000webhostapp.com/Apicalling/$imagepath"),
                  ),
                  accountName: Text(name!),
                  accountEmail: Text(email!)),
              ListTile(
                onTap: () {
                  setState(() {
                    cnt = 0;
                  });
                  Navigator.pop(context);
                },
                leading: Icon(Icons.shopping_cart_rounded),
                title: Text("Add Product"),
                trailing: Icon(Icons.add),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    cnt = 1;
                  });
                  Navigator.pop(context);
                },
                leading: Icon(Icons.shopping_cart_rounded),
                title: Text("View Product"),
                trailing: Icon(Icons.add),
              ),
              ListTile(
                onTap: () {

                  page3.prefrs!.setBool("loginstatus", false);

                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return login();
                    },
                  ));
                },
                title: Text(
                  "Log out",
                  style: TextStyle(color: Colors.red.shade500),
                ),
                leading: Icon(Icons.exit_to_app),
              ),
              // Container(margin: EdgeInsets.only(left: 90,right: 90),
              //   child: ElevatedButton(onPressed: () {
              //
              //   }, child: Text("Log out")),
              // )
            ],
          ),
          backgroundColor: Colors.lightGreenAccent),
    );
  }
}
