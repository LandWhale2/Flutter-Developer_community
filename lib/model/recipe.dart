class Recipe{
  String name;
  String type;
  int orderCount;
  int price;
  Map<String, dynamic> ingredients;

  Recipe({this. price, this.name, this.type, this.ingredients, this.orderCount});


  //json 데이터 클래스 형식으로 변환
  Recipe.fromJson(Map<String, dynamic> json) :
      name = json['name'],
      type = json['type'],
      price = json['price'],
      orderCount = json['orderCount'],
      ingredients = json['ingredients'];
}