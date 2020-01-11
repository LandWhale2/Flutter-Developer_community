import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
        "sender" : "me"
      }));
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}