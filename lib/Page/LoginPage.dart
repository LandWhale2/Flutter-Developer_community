import 'dart:convert';

import 'package:developercommunity/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences prefs;
  String _email, _password;
  
  
  Future<String> SignIn() async {
    if(_email != null && _password != null){
      prefs = await SharedPreferences.getInstance();

      String addr = '${ServerIp}auth/signin';
      var response = await http.post(addr, body: {'email': _email, 'password': _password});
      // 200 ok. 정상 동작임을 알려준다.
      if(response.statusCode == 200){
        var utf8convert= utf8.decode(response.bodyBytes);//한글화
        Map data = json.decode(utf8convert);
        print(data['data']);
        await prefs.setString('email', data['data']['email']);
        await prefs.setString('nickname', data['data']['nickname']);
        await prefs.setInt('id', data['data']['id']);
        await prefs.setString('token', data['data']['token']);
        Fluttertoast.showToast(
            msg: '로그인.',
            backgroundColor: Colors.white,
            textColor: Colors.black,
            gravity: ToastGravity.TOP
        );
        Navigator.of(context).pushNamed('/home');
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
  }
  
  isSignedIn()async{
    prefs = await SharedPreferences.getInstance();
    if(prefs.getString('email') != null){
      print(prefs.getString('email'));
      Navigator.of(context).pushNamed('/home');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/background.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height / 3,),
                  loginform(context),
                  SizedBox(height: MediaQuery.of(context).size.height / 35,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: Text(
                      '계정이 없으신가요 ? 계정을 만들어볼까요 ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RIDI',
                        fontSize: MediaQuery.of(context).textScaleFactor*15,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 17,),
                  loginbutton(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginform(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: TextFormField(
                  onChanged: (input) => _email = input,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_box, color: Colors.white),
                    border: InputBorder.none,
                    hintText: '이메일',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                    contentPadding: EdgeInsets.only(
                        top: 30, right: 30, bottom: 30, left: 5),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: TextFormField(
                  onChanged: (input) => _password = input,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline, color: Colors.white),
                    border: InputBorder.none,
                    hintText: '비밀번호',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                    contentPadding: EdgeInsets.only(
                        top: 30, right: 30, bottom: 30, left: 5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget loginbutton(BuildContext context){
    return InkWell(
      onTap: (){
        SignIn();
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 20,
        width: MediaQuery.of(context).size.width / 2.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Colors.white]),
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            '로그인',
            style: TextStyle(
              fontSize: MediaQuery.of(context).textScaleFactor*25,
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'RIDI'
            ),
          ),
        ),
      ),
    );
  }
}
