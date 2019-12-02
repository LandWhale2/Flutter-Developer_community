//import 'dart:convert';
//
//import 'package:mongo_dart/mongo_dart.dart';
//
//
//
//class dbHelper{
//  dbHelper._();
//  static final dbHelper _db = dbHelper._();
//  factory dbHelper() => _db;
//
//  Db db = Db("mongodb://ec2-18-224-96-34.us-east-2.compute.amazonaws.com:27017/devel");
//
//
//
//
//  UploadContent(String menu,String content)async{
//    await db.open();
//    await db.authenticate('devel', 'devel');
//    db.collection(menu).insert({'time': DateTime.now().millisecondsSinceEpoch,'content': content,});
//    await db.close();
//    print('완료');
//  }
//
//  BoardList(String menu)async{
//    await db.open();
//    await db.authenticate('devel', 'devel');
//    var tmp = await db.collection(menu).find();
//    return tmp.first;
//  }
//
//}