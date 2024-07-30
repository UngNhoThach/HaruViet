import 'dart:async';
import 'package:haruviet/page/payment/widgets/payment_success.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int activeCard = 0;
  bool _isLoading = false;
  Timer? _timer;

  pay() {
    setState(() {
      _isLoading = true;
    });

    const oneSec = const Duration(seconds: 2);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          _isLoading = false;
          timer.cancel();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PaymentSuccess()));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Payment',
            style: TextStyle(color: Colors.black),
          ),
          leading: BackButton(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
          ),
        ));
  }
}
