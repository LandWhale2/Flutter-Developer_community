
import 'dart:io';

import 'package:developercommunity/utils/util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


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
  File ImageFile;
  SharedPreferences prefs;
  String imagepath;
  http.MultipartFile multipartFile;


  Future GetImage()async{
    ImageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

  }

  PostContent() async {
    if(content != null){
      prefs = await SharedPreferences.getInstance();
      if(ImageFile != null){
        imagepath = ImageFile.path;
      }



      String addr = '${ServerIp}api/${menu}/';
      var postUri = Uri.parse(addr);

      http.MultipartRequest request = http.MultipartRequest("POST", postUri);
      if(ImageFile != null){
        multipartFile = await http.MultipartFile.fromPath('image', imagepath);
      }



      request.fields['content'] = content;
      request.fields['writer'] = prefs.getString('nickname');
      if(ImageFile != null){
        request.files.add(multipartFile);
      }


      request.send().then((result) async {
        http.Response.fromStream(result).then((response){
          if(response.statusCode == 200 || response.statusCode == 201){
            print(response.body);
            Navigator.of(context).pop();
            return null;
          }else{
            print(response.body);
            Fluttertoast.showToast(
                msg: '오류',
                backgroundColor: Colors.white,
                textColor: Colors.black,
                gravity: ToastGravity.TOP
            );
            return null;
          }
        });
      });



    }else{
      Fluttertoast.showToast(
          msg: '내용을 입력해주세요',
          backgroundColor: Colors.white,
          textColor: Colors.black,
          gravity: ToastGravity.TOP
      );
    }
  }


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
                        PostContent();
                      },
                      child: Text('완료', style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor*25,
                          color: Colors.white
                      ),),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        GetImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Icon(Icons.save, color: Colors.white,),
                        ),
                      ),
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
                        onChanged: (value)=> content = value,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: (ImageFile != null)?Image.file(ImageFile):Container(),
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
