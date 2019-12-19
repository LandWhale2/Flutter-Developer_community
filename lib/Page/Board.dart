import 'dart:async';

import 'package:developercommunity/Page/WritePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Board extends StatefulWidget {
  String title, menu;
  Board({Key key, @required this.title, @required this.menu}):super(key:key);


  @override
  _BoardState createState() => _BoardState(title: title,menu: menu);

}

class _BoardState extends State<Board> {
  String title, menu;
  _BoardState({Key key, @required this.title, @required this.menu});
  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getData(String topic) async{
    http.Response response = await http.get(
        Uri.encodeFull('http://ec2-15-164-211-101.ap-northeast-2.compute.amazonaws.com:8000/api/${topic}/'),
        headers: {"Accept": "application/json"});
    var utf8convert= utf8.decode(response.bodyBytes);//한글화

    List data = json.decode(utf8convert);

    return data;
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(
          fontFamily: '',
          fontSize: MediaQuery.of(context).textScaleFactor*25,
        ),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 0, 10, 1),
        actions: <Widget>[
          InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => WritePage(menu: menu,)));
          },
              child: Icon(Icons.edit))
        ],
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
//        Navigator.of(context).pushNamed('/content');
//      boardlist();
      },
      child: FutureBuilder(
        future: getData('talk'),
        builder: (context ,snapshot) {

          if(!snapshot.hasData){
            return Container();
          }
          return ListView.builder(
              itemCount:snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index){
              var ds = snapshot.data;
              if(ds[index]['content'] == null){
                return Container();
              }
                return Padding(
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
                              (ds[index]['content'] != null)?ds[index]['content'].toString():'',
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
                                  '익명',
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
                );
          });
        }
      ),
    );
  }
}
