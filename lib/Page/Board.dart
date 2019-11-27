import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알고리즘', style: TextStyle(
          fontFamily: '',
          fontSize: MediaQuery.of(context).textScaleFactor*25,
        ),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 0, 10, 1),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(0, 0, 10, 1),
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Center(child: Feed(context, 'dd'))
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget Feed(BuildContext context, String content){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width /1.2,
        height: MediaQuery.of(context).size.height/10,
        decoration: BoxDecoration(
          border: Border.all(width: 0.3, color: Colors.white70),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black38,
        ),
        child: Center(
          child: Text(
            content,
            style: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor*20,
                fontFamily: 'RIDI',
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
