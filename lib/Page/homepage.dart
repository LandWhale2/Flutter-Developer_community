import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(0, 0, 10, 1),
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 40,),
                Row(
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Container(
                      child: Text(
                        '추천',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor*30,
                          color: Colors.white,
                          fontFamily: 'RIDI',
                        ),
                      ),
                    ),
                  ],
                ),//추천
                SizedBox(height: 30,),
                Container(
                  width: MediaQuery.of(context).size.width /1.2,
                  height: MediaQuery.of(context).size.height/25,
                  decoration: BoxDecoration(
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
