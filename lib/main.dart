import 'package:developercommunity/Page/Board.dart';
import 'package:developercommunity/Page/homepage.dart';
import 'package:flutter/material.dart';

import 'Page/Content.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/home' : (BuildContext context) => HomePage(),
        '/board' : (BuildContext context) => Board(),
        '/content' : (BuildContext context) => Content() ,
      },
      home: HomePage(),
    );
  }
}
