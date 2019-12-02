import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/recipe.dart';


class API{
  String baseUrl = "https://q6184s3871.execute-api.ap-northeast-2.amazonaws.com/dev";
  final client = http.Client();

  Future<Recipe> fetchRecipe(String type, String name) async{
    var path = "/recipes?type=${type}&name=${name}";
    var url = baseUrl + path;

    final response = await client.get(url); // http get 메소드로 리퀘

    var data= json.decode(utf8.decode(response.bodyBytes));//한글이 깨지지않게

    return Recipe.fromJson(data['Item']);
  }

  Future<void> postdata(String data)async{

  }
}


