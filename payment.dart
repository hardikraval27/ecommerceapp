import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class payment1 extends StatefulWidget {
  String? pRODUCTNAME;
  payment1(this.pRODUCTNAME);


  @override
  State<payment1> createState() => _payment1State();
}
class _payment1State extends State<payment1> {

  Razorpay? razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    razorpay = Razorpay();

    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }
  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Fluttertoast.showToast(
        msg: "payment success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(
        msg: "Payment fail",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    Fluttertoast.showToast(
        msg: "Payment wallet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("payment"),
        centerTitle: true),

      body: Column(
        children: [
          Center(
            child: Container(
              child: ElevatedButton(onPressed: () {

                var options = {
                  'key': 'rzp_test_USsS405piO3nOR',
                  'amount': 10000,
                  'name': widget.pRODUCTNAME,
                  'description': 'Fine T-Shirt',
                  'prefill': {
                    'contact': '8488871384',
                    'email': 'test@razorpay.com'
                  }
                };
                  razorpay!.open(options);
              }, child: Text("Paymment")),
            ),
          )
        ],
      ),
    );
  }
}
