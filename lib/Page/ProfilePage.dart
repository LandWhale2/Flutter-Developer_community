import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:developercommunity/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String _nickname;
  SharedPreferences prefs;

  PostProfile()async{

    if(_nickname != null){
      String addr = '${ServerIp}auth/userupdate';

      final Map<String, dynamic> activityData = {
        'token' : prefs.getString('token'),
        'nickname':_nickname
      };

      Map<String, String> Header = {
        'Content-type' : 'application/json',
        'Accept': 'application/json'};

      var response = await http.post(addr, body: json.encode(activityData),headers: Header);
      // 200 ok. 정상 동작임을 알려준다.
      if(response.statusCode == 200){
        print(response.body);
        await prefs.setString('nickname', _nickname);
        Navigator.pop(context);
      }else{
        print(response.body);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/10),
                child: Container(
                  child: Text(
                    '프로필 수정',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RIDI',
                        fontSize: MediaQuery.of(context).textScaleFactor*30
                    ),
                  ),
                ),
              ),//회원가입
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/14),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width/2,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/14),
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
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
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
                        onTap: ()async{
                          prefs = await SharedPreferences.getInstance();
                          PostProfile();
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
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
