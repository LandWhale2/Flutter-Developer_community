import 'package:developercommunity/Page/Board.dart';
import 'package:developercommunity/Page/WritePage.dart';
import 'package:developercommunity/Page/homepage.dart';
import 'package:flutter/material.dart';

import 'Page/Content.dart';
import 'Page/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/login' : (BuildContext context) => LoginPage(),
        '/home' : (BuildContext context) => HomePage(),
        '/board' : (BuildContext context) => Board(),
        '/content' : (BuildContext context) => Content() ,
        '/write' : (BuildContext context) => WritePage() ,
      },
      home: LoginPage(),
    );
  }
}
