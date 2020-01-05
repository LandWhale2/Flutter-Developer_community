import 'package:flutter/material.dart';


class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스토어', style: TextStyle(
          fontSize: MediaQuery.of(context).textScaleFactor*25,
        ),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 0, 10, 1),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            PayMent(context, '1000원'),
            PayMent(context, '5000원'),
            PayMent(context, '10000원'),
            PayMent(context, '30000원'),
          ],
        ),
      ),
    );
  }

  Widget PayMent(BuildContext context, String money){
    return Container(
      width: MediaQuery.of(context).size.width/1.3,
      height: MediaQuery.of(context).size.height/20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
        child: Text(
          money,
          style: TextStyle(
            fontSize: MediaQuery.of(context).textScaleFactor*25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
