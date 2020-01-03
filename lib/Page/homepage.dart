import 'dart:convert';

import 'package:developercommunity/Page/Board.dart';
import 'package:developercommunity/Page/ChatPage.dart';
import 'package:developercommunity/Page/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height/15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Container(
                          child: Text(
                            '추천',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).textScaleFactor*30,
                              color: Colors.white,
                              fontFamily: 'RIDI',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Container(
                            child: Text(
                              '채팅',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).textScaleFactor*30,
                                color: Colors.white,
                                fontFamily: 'RIDI',
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Container(
                            child: Text(
                              '내 정보',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).textScaleFactor*30,
                                color: Colors.white,
                                fontFamily: 'RIDI',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),//추천
                  SizedBox(height: 30,),
                  Recommend(context, '필요한 토이 프로젝트를 찾는법'),
                  Recommend(context, '뗄감이 되지않는 3가지 방법'),
                  Recommend(context, '좋은 회사를 찾는 노하우'),
                  SizedBox(height: 20,),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 30,),
                      Container(
                        child: Text(
                          '메뉴',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).textScaleFactor*30,
                            color: Colors.white,
                            fontFamily: 'RIDI',
                          ),
                        ),
                      ),
                    ],
                  ),//메뉴
                  SizedBox(height: 10,),
                  Menu(context, '알고리즘 문제 모음', Colors.cyan, 'algorithm'),
                  Menu(context, '토이 프로젝트 추천', Colors.redAccent, 'projects'),
                  Menu(context, '기술 토론', Colors.indigo, 'skilltalk'),
                  Menu(context, '잡담', Colors.green,'talk'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget Menu(BuildContext context, String title, Color color, String menu){
    return InkWell(
      onTap: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context) => Board(title: title, menu: menu,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width /1.2,
          height: MediaQuery.of(context).size.height/15,
          decoration: BoxDecoration(
            border: Border.all(width: 0.3, color: Colors.white70),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: color,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor*20,
                  fontFamily: 'RIDI',
                  color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Recommend(BuildContext context, String content){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width /1.2,
        height: MediaQuery.of(context).size.height/15,
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
