import 'package:flutter/material.dart';
import 'package:myecommerceapp/payment.dart';
import 'package:myecommerceapp/view_product.dart';

class buy extends StatefulWidget {
  Productdata productdata;

  buy(this.productdata);

  @override
  State<buy> createState() => _buyState();
}

class _buyState extends State<buy> {
  // bool hh = true;

  bool maxline = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Productview"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(margin: const EdgeInsets.only(right: 10,left: 10),
                    height: size.height * 0.5,
                    width: size.width * 9.5,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://hardik027.000webhostapp.com/Apicalling/${widget.productdata.iMAGEPRODUCT}"),
                            fit: BoxFit.fill)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 335,
                            ),
                            height: 35,
                            width: 50,
                            child: const Icon(
                              Icons.share,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 350, top: 295),
                            height: 35,
                            width: 50,
                            child: const Icon(
                              Icons.favorite,
                              size: 35,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      " Name:- ${widget.productdata.pRODUCTNAME}",
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      " Price:- ₹${widget.productdata.pRODUCTSELLINGPRICE}/-",
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text.rich(TextSpan(
                        text: " M.R.P:-",
                        style: const TextStyle(fontSize: 25),
                        children: [
                          TextSpan(
                              text: "₹${widget.productdata.pRODUCTMRP}/-",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough)),
                        ])),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      " Stock:- ${widget.productdata.pRODUCTSTOCK}/-",
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 170),
                    child: Column(
                      children: [
                        Text(
                          " Discription:- ${widget.productdata.pRODUCTDESCRIPTION}",
                          maxLines: maxline ? 4 : null,
                          style: const TextStyle(fontSize: 25),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (maxline) {
                                    maxline = false;
                                  } else {
                                    maxline = true;
                                  }
                                });
                              },
                              child: Text(maxline ? "more..." : "less...")),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return  payment1(widget.productdata.pRODUCTNAME);
                          },));
                        },
                          child: Container(margin: const EdgeInsets.only(left: 10),
                            height: 60,
                            width: 180,
                            child: const Center(
                                child: Text(
                              "Add cart",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            )),
                            decoration: BoxDecoration(
                                color: Colors.lightGreenAccent,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.tealAccent,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return  payment1(widget.productdata.pRODUCTNAME);
                          },));
                        },
                          child: Container(margin: const EdgeInsets.only(right: 10),
                            height: 60,
                            width: 180,
                            child: const Center(
                                child: Text(
                                  "Buy now",
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                )),
                            decoration: BoxDecoration(
                                color: Colors.lightGreenAccent,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.tealAccent,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
