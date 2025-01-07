import 'package:flutter/material.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';

class CreditCardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildCreditCard(
          color: Color.fromARGB(255, 46, 114, 231),
          cardExpiration: "05/2024",
          cardHolder: "NGUYỄN VĂN ABC",
          cardNumber: "SLG VIET NAM | MASTERCARD"),
    );
  }

  // Build the title section

  // Build the credit card widget
  Card _buildCreditCard(
      {required Color color,
      required String cardNumber,
      required String cardHolder,
      required String cardExpiration}) {
    return Card(
      elevation: 1.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //  _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                cardNumber,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.black45)),
                  child: Image.asset(
                    color: colorWhite,
                    'assets/images/qr_png.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    const Text(
                      'THẺ TRỊ LIỆU',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CourrierPrime'),
                    ),
                    spaceH4,
                    const Text(
                      '9849283948',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'Người đại diện',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'Ngày tạo', value: cardExpiration),
                Image.asset(
                  color: colorWhite,
                  'assets/logo/logo.png',
                  height: 52,
                  width: 72,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/contact_less.png",
          height: 20,
          width: 18,
        ),
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

// Build the FloatingActionButton
  Container _buildAddCardButton({
    required Icon icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 2.0,
        onPressed: () {
          print("Add a credit card");
        },
        backgroundColor: color,
        mini: false,
        child: icon,
      ),
    );
  }
}
