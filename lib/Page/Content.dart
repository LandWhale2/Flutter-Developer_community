import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
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
      body: Container(
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
                    child: Text('글 내용글 내용글 내용글 내용글 내용글 내용 내용글 내용글 내용글 내용글 내용글 내용글 내용', style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaleFactor*20,
                      fontFamily: 'RIDI',
                      color: Colors.white,
                    ),),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width /2.3,
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
                      ),
                    ],
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
