import 'dart:convert';

import 'package:developercommunity/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class SocketTest extends StatefulWidget {
  final String title;
  final WebSocketChannel channel;

  SocketTest({Key key, @required this.title, @required this.channel})
      : super(key: key);

  @override
  _SocketTestState createState() => _SocketTestState();
}

class _SocketTestState extends State<SocketTest> {
  TextEditingController _controller = TextEditingController();
  
  List<String> messages;
  ScrollController scrollController;

  Future GetMessage(int myid, int peerid) async{
    http.Response response = await http.get(
        Uri.encodeFull('${ServerIp}chat/api/messages/${myid}/${peerid}'),
        headers: {"Accept": "application/json"});
    var utf8convert= utf8.decode(response.bodyBytes);//한글화

    List data = json.decode(utf8convert);
    return data;
  }

  @override
  void initState() {
    //Initializing the message list
    messages = List<String>();
    //Initializing the TextEditingController and ScrollController
//    textController = TextEditingController();
//    scrollController = ScrollController();
//    //Creating the socket
//    socketIO = SocketIOManager().createSocketIO(
//      'https://real-chat-1234.herokuapp.com',
//      '/',
//    );
//    //Call init before doing anything with socket
//    socketIO.init();
//    //Subscribe to an event to listen to
//    socketIO.subscribe('receive_message', (jsonData) {
//      //Convert the JSON data received into a Map
//      Map<String, dynamic> data = json.decode(jsonData);
//      this.setState(() => messages.add(data['message']));
//      scrollController.animateTo(
//        scrollController.position.maxScrollExtent,
//        duration: Duration(milliseconds: 600),
//        curve: Curves.ease,
//      );
//    });
//    //Connect to the socket
//    socketIO.connect();


//    widget.channel.stream.listen((message){
//
//    });
    
    super.initState();
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/15,
              child: StreamBuilder(
                stream: widget.channel.stream,
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Container();
                  }
                  return Container(
                    child: Text(
                      (snapshot.data != null)?snapshot.data:'',
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      print(_controller.text);
      widget.channel.sink.add(json.encode({
        'message': _controller.text,
        'receiver' : 4,
        'sender' : 2
//        "timestamp" : DateTime.now().millisecondsSinceEpoch,
      }));
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}