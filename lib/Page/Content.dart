import 'dart:convert';

import 'package:developercommunity/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Content extends StatefulWidget {
  int contentid;
  String menu;
  Content({Key key, @required this.contentid, @required this.menu}):super(key:key);

  @override
  _ContentState createState() => _ContentState(contentid: contentid, menu: menu);
}

class _ContentState extends State<Content> {
  int contentid;
  String menu;
  _ContentState({Key key, @required this.contentid, @required this.menu});

  Future GetContentData() async{
    http.Response response = await http.get(
        Uri.encodeFull('${ServerIp}api/${menu}/${contentid}/'),
        headers: {"Accept": "application/json"});
    var utf8convert= utf8.decode(response.bodyBytes);//한글화
    return json.decode(utf8convert);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글', style: TextStyle(
          fontFamily: '',
          fontSize: MediaQuery.of(context).textScaleFactor*25,
        ),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 0, 10, 1),
      ),
      body: FutureBuilder(
        future: GetContentData(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Container();
          }
          var ds = snapshot.data;
          return Container(
            child: Stack(
              children: <Widget>[
                Container(
                  color: Color.fromRGBO(0, 0, 10, 1),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text((ds['content'] != null)?ds['content']:'', style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor*20,
                          fontFamily: 'RIDI',
                          color: Colors.white,
                        ),),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: (ds['image'] != null)?Container(
                        child: Image.network(ds['image']),
                      ):Container(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width /2.1,
                      height: MediaQuery.of(context).size.height/8,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.3, color: Colors.white70),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black38,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              FlatButton.icon(
                                label: Text(
                                  '좋아요',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                                icon: Icon(Icons.favorite,color: Colors.white,size: 15,),
                              ),
                              FlatButton.icon(
                                label: Text(
                                  '댓글',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                                icon: Icon(Icons.comment,color: Colors.white,size: 15,),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('11', style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).textScaleFactor*20),),
                              Text('1', style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).textScaleFactor*20),),
                            ],
                          ),
                        ],
                      ),
                    ),//좋아요 댓글 박스
                    SizedBox(height: 20,),
                    Feed(context),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 0.1,color: Colors.white
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width/1.2,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.1),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize:MediaQuery.of(context).textScaleFactor*20,
                                  fontFamily: 'RIDI', color: Colors.white),
                                  controller: null,
                                  maxLength: 100,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintStyle: TextStyle(
                                      fontSize: MediaQuery.of(context).textScaleFactor*20,
                                      fontFamily: 'RIDI',
                                      color: Colors.white,
                                    ),
                                    hintText: '댓글을 입력해주세요.',
                                    border:InputBorder.none,
                                  ),
                                  onChanged: (String value){

                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/10,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1)
                            ),
                            child: Text('전송', style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*18),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),//댓글부분
              ],
            ),
          );
        }
      ),
    );
  }

  Widget Feed(BuildContext context){
    return InkWell(
      onTap: (){
        GetContentData();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width /1.2,
//          height: MediaQuery.of(context).size.height/10,
          decoration: BoxDecoration(
            border: Border.all(width: 0.3, color: Colors.white70),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black26,
          ),
          child: Column(
            children: <Widget>[
              Container(//내용
                width: MediaQuery.of(context).size.width /1.2,
//                height: MediaQuery.of(context).size.height/18,
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
                    '개쓰레기 알고리즘 모아놓고 30선 알고리즘 이라고하네 ㅋㅋ',
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
                      width: MediaQuery.of(context).size.width /4,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/3.5,
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
