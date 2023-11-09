import 'package:nutrition_assistant/models/recipe/ingredient.dart';
import 'package:nutrition_assistant/models/recipe/nutrient.dart';

Recipe getEmptyRecipe(){
  return Recipe(
      id: "",
      label: "",
      image: "",
      source: "",
      dietLabels: [],
      healthLabels: [],
      cautions: [],
      ingredientLines: [],
      ingredients: [],
      calories: 0,
      totalWeight: 0,
      totalTime: 0,
      cuisineType: [],
      mealType: [],
      dishType: [],
      totalNutrients: []
  );
}

class Recipe{
  final String id;
  final bool favorite;
  final String label;
  final String image;
  final String source;
  final List<String> dietLabels;
  final List<String> healthLabels;
  final List<String> cautions;
  final List<String> ingredientLines;
  final List<Ingredient> ingredients;
  final double calories;
  final double totalWeight; //gram
  final double totalTime; //min
  final List<String> cuisineType;
  final List<String> mealType;
  final List<String> dishType;
  final List<Nutrient> totalNutrients;

  static String createSQL =
      "CREATE TABLE Recipe ("
        "Id	TEXT NOT NULL UNIQUE, "
        "Label TEXT,"
        "Image TEXT,"
        "Source TEXT,"
        "DietLabels TEXT,"
        "HealthLabels TEXT,"
        "Cautions TEXT,"
        "IngredientLines TEXT,"
        "Calories REAL,"
        "TotalWeight REAL,"
        "TotalTime REAL,"
        "CuisineType TEXT,"
        "MealType TEXT,"
        "DishType TEXT,"
        "PRIMARY KEY(Id)"
      ");";

  Recipe({
      required this.id,
      this.favorite = false,
      required this.label,
      required this.image,
      required this.source,
      required this.dietLabels,
      required this.healthLabels,
      required this.cautions,
      required this.ingredientLines,
      required this.ingredients,
      required this.calories,
      required this.totalWeight,
      required this.totalTime,
      required this.cuisineType,
      required this.mealType,
      required this.dishType,
      required this.totalNutrients
  });

  factory Recipe.fromMapOnDB(
      List<Ingredient>? listIngr, List<Nutrient>? listNurt,
      Map<String, dynamic> json) => Recipe(
      id: json["Id"],
      favorite: true,
      label: json["Label"],
      image: json["Image"],
      source: json["Source"],
      dietLabels: json["DietLabels"].split("|").sublist(1),
      healthLabels: json["HealthLabels"].split("|").sublist(1),
      cautions: json["Cautions"].split("|").sublist(1),
      ingredientLines: json["IngredientLines"].split("|").sublist(1),
      ingredients: listIngr ?? [],
      calories: json["Calories"],
      totalWeight: json["TotalWeight"],
      totalTime: json["TotalTime"],
      cuisineType: json["CuisineType"].split("|").sublist(1),
      mealType: json["MealType"].split("|").sublist(1),
      dishType: json["DishType"].split("|").sublist(1),
      totalNutrients: listNurt ?? []
  );

  String parseListToString(List<String> list){
    var dietLabels = "";
    for (var element in list) {
      dietLabels += "|${element}";
    }
    return dietLabels;
  }
}