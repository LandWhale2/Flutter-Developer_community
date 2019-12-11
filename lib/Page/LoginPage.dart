import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;

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
                  Text(
                    '계정이 없으신가요 ? 계정을 만들어볼까요 ?',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'RIDI',
                      fontSize: MediaQuery.of(context).textScaleFactor*15,
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
                  validator: (input) {
                    if (input.isEmpty) return '이메일을 입력해주세요';
                  },
                  onSaved: (input) => _email = input,
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
                  validator: (input) {
                    if (input.isEmpty) return '비밀 번호를 입력해주세요';
                  },
                  onSaved: (input) => _password = input,
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
        Navigator.of(context).pushNamed('/home');
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
