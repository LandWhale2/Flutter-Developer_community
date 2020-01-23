import 'dart:convert';

import 'package:developercommunity/Page/Chatting.dart';
import 'package:developercommunity/Page/sockettest.dart';
import 'package:developercommunity/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


  SharedPreferences prefs;

  Future GetUserList() async{
    http.Response response = await http.get(
        Uri.encodeFull(UserListUrl),
        headers: {"Accept": "application/json"});
    var utf8convert= utf8.decode(response.bodyBytes);//한글화

    List data = json.decode(utf8convert);

    return data;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('채팅', style: TextStyle(
          fontSize: MediaQuery.of(context).textScaleFactor*25,
        ),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 0, 10, 1),
        actions: <Widget>[
          InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SocketTest(title: 'dd',
            channel: IOWebSocketChannel.connect('ws://127.0.0.1:8000/ws/chatting/1/'),)));
          },
              child: Icon(Icons.assignment_ind))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: GetUserList(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Container();
                  }

                  return ListView.builder(
                  itemCount:snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index){
                    var ds  = snapshot.data[index];
                    if(!snapshot.hasData) {
                      return Container();
                    }
                    return UserList(context,ds['nickname'], ds['id']);
                    }
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget UserList(BuildContext context, String username,int peerid) {
    return InkWell(
      onTap: () async {
        prefs = await SharedPreferences.getInstance();
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            Chatting(peerId: peerid,
              channel: IOWebSocketChannel.connect('ws://127.0.0.1:8000/ws/chatting/1/'),
              peernickname: username,
              myid: prefs.getInt('id'),
              mynickname: prefs.getString('nickname'),)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width / 1.2,
          height: MediaQuery
              .of(context)
              .size
              .height / 8,
          decoration: BoxDecoration(
            border: Border.all(width: 0.3, color: Colors.white70),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black26,
          ),
          child: Column(
            children: <Widget>[
              Container( //내용
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.2,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 18,
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
                    '마지막대화',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery
                          .of(context)
                          .textScaleFactor * 20,
                      fontFamily: 'RIDI',
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.2,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 23,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 3,),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 3.5,
                      child: Text(
                        '',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: MediaQuery
                              .of(context)
                              .textScaleFactor * 17,
                          fontFamily: 'RIDI',
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 5,
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 3,
                      child: Text(
                        (username != null)? username:'',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: MediaQuery
                              .of(context)
                              .textScaleFactor * 15,
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
