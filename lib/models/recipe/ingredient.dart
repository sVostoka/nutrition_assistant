Ingredient getEmptyIngredient(){
  return Ingredient(
      text: "",
      quantity: 0,
      measure: "",
      food: "",
      weight: 0,
      foodCategory: "",
      foodId: "",
      image: ""
  );
}

class Ingredient{
  final int id;
  final String recipeId;
  final String text;
  final double quantity;
  final String measure;
  final String food;
  final double weight;
  final String foodCategory;
  final String foodId;
  final String image;

  static String createSQL =
      "CREATE TABLE Ingredient ("
        "Id	INTEGER NOT NULL UNIQUE, "
        "RecipeId TEXT,"
        "Text TEXT,"
        "Quantity REAL,"
        "Measure TEXT,"
        "Food TEXT,"
        "Weight REAL,"
        "FoodCategory TEXT,"
        "FoodId TEXT,"
        "Image REAL,"
        "PRIMARY KEY(Id AUTOINCREMENT)"
      ");";

  Ingredient({
    this.id = 0,
    this.recipeId = "",
    required this.text,
    required this.quantity,
    required this.measure,
    required this.food,
    required this.weight,
    required this.foodCategory,
    required this.foodId,
    required this.image,
  });

  factory Ingredient.fromMapOnAPI(Map<String, dynamic> json) => Ingredient(
    text: json["text"] ?? "",
    quantity: json["quantity"].toDouble() ?? "",
    measure: json["measure"] ?? "",
    food: json["food"] ?? "",
    weight: json["weight"].toDouble() ?? 0,
    foodCategory: json["foodCategory"] ?? "",
    foodId: json["foodId"] ?? "",
    image: json["image"] ?? "",
  );

  factory Ingredient.fromMapOnDB(Map<String, dynamic> json) => Ingredient(
    text: json["Text"] ?? "",
    quantity: json["Quantity"],
    measure: json["Measure"] ?? "",
    food: json["Food"] ?? "",
    weight: json["Weight"],
    foodCategory: json["FoodCategory"] ?? "",
    foodId: json["FoodId"] ?? "",
    image: json["Image"] ?? "",
  );
}