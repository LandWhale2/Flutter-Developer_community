import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:developercommunity/utils/util.dart';

class Chatting extends StatefulWidget {
  int peerId, myid;
  String peernickname,mynickname;
  Chatting({Key key, @required this.peerId, @required this.peernickname, @required this.myid, @required this.mynickname}):super(key:key);
  @override
  _ChattingState createState() => _ChattingState(peerId: peerId, peernickname: peernickname,myid: myid, mynickname: mynickname);
}

class _ChattingState extends State<Chatting> {
  int peerId, myid;
  String peernickname, mynickname;
  TextEditingController textEditingController = TextEditingController();
  _ChattingState({Key key, @required this.peerId, @required this.peernickname, @required this.myid, @required this.mynickname});


  Future onSendMessage(String content) async {
    if(content != null && myid != null){
      String addr = '${ServerIp}chat/api/messages/${myid}/${peerId}';
      final Map<String, dynamic> activityData = {
        'message': content,
        'sender': mynickname,
        'receiver': peernickname,
      };
      textEditingController.clear();
      var response = await http.post(addr, body: json.encode(activityData),headers: Header);
      // 200 ok. 정상 동작임을 알려준다.
      if(response.statusCode == 200){
        print(response.body);
        setState(() {
        });

      }else{
        print(response.body);
        setState(() {
        });
      }
    }else{
      print('no');
    }
  }


  Future GetMessage(int myid, int peerid) async{
    http.Response response = await http.get(
        Uri.encodeFull('${ServerIp}chat/api/messages/${myid}/${peerid}'),
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
      ),
      body: Column(
        children: <Widget>[
          buildListMessage(),
          buildInput(),
        ],
      ),
    );
  }

  Widget buildItem(var ds){
    return Container(
      child: Text(
          (ds['message'] != null)? ds['message']: '',style: TextStyle(color: Colors.white),
      ),
    );
  }


  buildListMessage() {
    return Flexible(
        child:FutureBuilder(
              future: GetMessage(myid, peerId),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Container();
                }
                return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data.length,
                    reverse: true,
//                controller: listScrollController,
                    itemBuilder:(context, index){
                      return buildItem(snapshot.data[index]);
                    }
                  );
              },
            ),
        );
  }

  Widget buildInput(){
    return Container(
      child: Row(
        children: <Widget>[
          //이미지 전송버튼
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: Colors.black87, fontSize: 15),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(hintText: 'Type your message', hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
          ),

          //전송버튼
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text),
                color: Colors.black87,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          border: Border(top:BorderSide(color: Colors.grey, width: 0.5)), color: Colors.white),
    );
  }


}
