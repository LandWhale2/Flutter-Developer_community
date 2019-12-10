
import 'package:flutter/material.dart';

class WritePage extends StatefulWidget {
  String menu;
  WritePage({Key key,@required this.menu}):super(key:key);


  @override
  _WritePageState createState() => _WritePageState(menu: menu);
}

class _WritePageState extends State<WritePage> {
  String menu;
  _WritePageState({Key key, @required this.menu});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String content;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(0, 0, 11, 1),
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(onTap: (){Navigator.pop(context);},
                        child: Icon(Icons.arrow_back,color: Colors.white,size: MediaQuery.of(context).textScaleFactor*30,)),
                    Text('글쓰기', style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaleFactor*25,
                      color: Colors.white
                    ),),
                    InkWell(
                      onTap: (){
                      },
                      child: Text('완료', style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor*25,
                          color: Colors.white
                      ),),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Form(
                      key: _formkey,
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
                          hintText: '내용을 입력해주세요.',
                          border:InputBorder.none,
                        ),
                        onSaved: (value)=> content = value,
                        validator: (value){
                          if(value.isEmpty){
                            return '내용을 입력해주세요';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
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
