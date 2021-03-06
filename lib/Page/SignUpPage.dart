import 'dart:convert';

import 'package:developercommunity/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  String _email, _password, _password2, _nickname;
  String tmp;

  Future<String> EmailCheck() async {
    String addr = '${ServerIp}auth/check';
    var response = await http.post(addr, body: {'email': _email});
    // 200 ok. 정상 동작임을 알려준다.
    if(response.statusCode == 200){
      print(utf8.decode(response.bodyBytes));
      Fluttertoast.showToast(
          msg: '사용가능한 계정입니다.',
          backgroundColor: Colors.white,
          textColor: Colors.black,
          gravity: ToastGravity.TOP
      );
    }else{
      Fluttertoast.showToast(
          msg: utf8.decode(response.bodyBytes),
          backgroundColor: Colors.white,
          textColor: Colors.black,
          gravity: ToastGravity.TOP
      );
      return null;
    }
  }

  SignUp() async {
    if(_email != null && _nickname != null && _password != null && _password2 != null){
      if(_password == _password2){
        String addr = '${ServerIp}auth/signup';
        var response = await http.post(addr, body: {
          'email': _email,
          'password': _password,
          'nickname': _nickname});
        // 200 ok. 정상 동작임을 알려준다.
        if(response.statusCode == 200){
          print(utf8.decode(response.bodyBytes));
          Fluttertoast.showToast(
              msg: '회원가입 완료 메일을 확인해주세요.',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              gravity: ToastGravity.TOP
          );
          Navigator.of(context).pop();
          return null;
        }else{
          Fluttertoast.showToast(
              msg: '이메일이 이미 존재합니다.',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              gravity: ToastGravity.TOP
          );
          print(utf8.decode(response.bodyBytes));
          return null;
        }
      }else{
        Fluttertoast.showToast(
            msg: '패스워드가 일치하지않습니다.',
            backgroundColor: Colors.white,
            textColor: Colors.black,
            gravity: ToastGravity.TOP
        );
        return null;
      }
    }else{
      Fluttertoast.showToast(
          msg: '모든 입력을 완료해주세요.',
          backgroundColor: Colors.white,
          textColor: Colors.black,
          gravity: ToastGravity.TOP
      );
      return null;
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.black,
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Container(
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'RIDI',
                            fontSize: MediaQuery.of(context).textScaleFactor*30
                          ),
                        ),
                      ),
                    ),//회원가입
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width/2,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              //이메일
                              width: MediaQuery.of(context).size.width / 1.7,
                              height: MediaQuery.of(context).size.height / 20,
                              alignment: FractionalOffset.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(const Radius.circular(20)),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                  ),
                                  border: InputBorder.none,
                                  hintText: '이메일',
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: Colors.black,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      top: 15, right: 30, bottom: 0, left: 5),
                                ),
                                onChanged: (value) => _email = value,
                              ),
                            ),//이메일
                          InkWell(
                            onTap: (){
                              if(_email != null){
                                EmailCheck().then((s){
                                  setState(() {
                                    tmp = s;
                                  });
                                });
                              }else{
                                Fluttertoast.showToast(
                                    msg: '이메일을 입력해주세요.',
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  gravity: ToastGravity.TOP
                                );
                              }
                              print(tmp);

                              if(tmp != null){
                                Fluttertoast.showToast(
                                    msg: tmp,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    gravity: ToastGravity.TOP
                                );
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              height: MediaQuery.of(context).size.height / 20,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.1),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white
                              ),
                              child: Center(
                                child: Text(
                                  '중복검사',
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).textScaleFactor*25,
                                    fontFamily: 'RIDI',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),//이메일
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Container(
                        //닉네임
                        width: MediaQuery.of(context).size.width / 1.7,
                        height: MediaQuery.of(context).size.height / 20,
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(const Radius.circular(20)),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 20,
                            ),
                            border: InputBorder.none,
                            hintText: '닉네임',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            contentPadding: const EdgeInsets.only(
                                top: 15, right: 30, bottom: 0, left: 5),
                          ),
                          onChanged: (value) => _nickname = value,
                        ),
                      ),
                    ),//닉네임
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Container(
                        //이메일
                        width: MediaQuery.of(context).size.width / 1.7,
                        height: MediaQuery.of(context).size.height / 20,
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(const Radius.circular(20)),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 20,
                            ),
                            border: InputBorder.none,
                            hintText: '비밀번호 입력',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            contentPadding: const EdgeInsets.only(
                                top: 15, right: 30, bottom: 0, left: 5),
                          ),
                          onChanged: (value) => _password = value,
                        ),
                      ),
                    ),//비밀번호
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Container(
                        //비밀번호 재입력
                        width: MediaQuery.of(context).size.width / 1.7,
                        height: MediaQuery.of(context).size.height / 20,
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(const Radius.circular(20)),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 20,
                            ),
                            border: InputBorder.none,
                            hintText: '비밀번호 재입력',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.black,
                            ),
                            contentPadding: const EdgeInsets.only(
                                top: 15, right: 30, bottom: 0, left: 5),
                          ),
                          onChanged: (value) => _password2 = value,
                        ),
                      ),
                    ),//비밀번호 재입력
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap:(){
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                height: MediaQuery.of(context).size.height / 20,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.1),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white
                                ),
                                child: Center(
                                  child: Text(
                                    '취소',
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).textScaleFactor*25,
                                      fontFamily: 'RIDI',
                                    ),
                                  ),
                                ),
                              ),
                            ),//취소버튼
                            InkWell(
                              onTap: (){
                                SignUp();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                height: MediaQuery.of(context).size.height / 20,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.1),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white
                                ),
                                child: Center(
                                  child: Text(
                                    '완료',
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).textScaleFactor*25,
                                      fontFamily: 'RIDI',
                                    ),
                                  ),
                                ),
                              ),
                            ),//완료버튼
                          ],
                        ),
                      ),
                    ),//취소,완료 버튼
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
