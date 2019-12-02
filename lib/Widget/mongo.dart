import 'package:mongo_dart/mongo_dart.dart';



class dbHelper{
  dbHelper._();
  static final dbHelper _db = dbHelper._();
  factory dbHelper() => _db;

  Db db = Db("mongodb://ec2-18-224-96-34.us-east-2.compute.amazonaws.com:27017/test");

  init()async{
    await db.open();
    await db.authenticate('test', 'test');
    var coll = db.collection('user');
    await coll.insert({'user': 'dd', 'name': 'kall', 'age': 22});
    await db.close();
    print('ss');
  }

  datafind()async{
    await db.open();
    await db.authenticate('test', 'test');
    var coll = db.collection('user');
    await coll.find(where.gt('age', 1).sortBy('age')).forEach((v) => print(v));
    await db.close();
  }


}