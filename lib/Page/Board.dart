import 'dart:async';

import 'package:developercommunity/api.dart';
import 'package:developercommunity/model/recipe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Board extends StatefulWidget {

  API api = API();

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }






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
              color: Color.fromRGBO(0, 0, 11, 1),
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Center(child: Feed(context)),
                SizedBox(height: 10,),
                FutureBuilder<Recipe>(
                  future: widget.api.fetchRecipe('Western', 'Carbaonara'),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      Recipe recipe = snapshot.data;
                      print('sd');
                      return Container(child: Text(recipe.price.toString()),);
                    }else{
                      print('aa');
                      return Container();
                    }

                  }
                )
              ],
            ),
          ],
        ),
      ),
    );
  }



  Widget Feed(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed('/content');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width /1.2,
          height: MediaQuery.of(context).size.height/10,
          decoration: BoxDecoration(
            border: Border.all(width: 0.3, color: Colors.white70),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black26,
          ),
          child: Column(
            children: <Widget>[
              Container(//내용
                width: MediaQuery.of(context).size.width /1.2,
                height: MediaQuery.of(context).size.height/18,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  border: Border(
                    bottom: BorderSide(
                      width: 0.4,
                      color: Colors.white
                    )
                  )
                ),
                child: Center(
                  child: Text(
                    '백준 기초 알고리즘 및 자료구조 30선',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).textScaleFactor*20,
                      fontFamily: 'RIDI',
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width /1.2,
                height: MediaQuery.of(context).size.height/23,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 3,),
                    Container(
                      width: MediaQuery.of(context).size.width /3.5,
                      child: Text(
                        '닉네임부분',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: MediaQuery.of(context).textScaleFactor*17,
                          fontFamily: 'RIDI',
                        ),
                      ),
                    ),
                    Container(//댓글부분만들려다가말았음
                      width: MediaQuery.of(context).size.width /5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/3,
                      child: Text(
                        '2019년10월11일',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: MediaQuery.of(context).textScaleFactor*15,
                          fontFamily: 'RIDI',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
