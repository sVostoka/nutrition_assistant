import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:nutrition_assistant/core/api_keys.dart';
import 'package:nutrition_assistant/database/DBProvider.dart';
import 'package:nutrition_assistant/models/performance/checkbox.dart';
import 'package:nutrition_assistant/models/recipe/ingredient.dart';
import 'package:nutrition_assistant/models/recipe/nutrient.dart';
import 'package:nutrition_assistant/models/recipe/recipe.dart';
import 'package:path_provider/path_provider.dart';

class RecipeAPI {

  static Future<List<Recipe>> getRecipes(
      {required Map<int, CheckBox> diets,
      required Map<int, CheckBox> health,
      required Map<int, CheckBox> cuisineType,
      required Map<int, CheckBox> typeMeal,
      required Map<int, CheckBox> dishType}) async {

    String dietsStr = "";
    diets.forEach((key, value) {
      if(value.check == true){
        dietsStr += "diet=${value.apiParameter}&";
      }
    });

    String healthStr = "";
    health.forEach((key, value) {
      if(value.check == true){
        healthStr += "health=${value.apiParameter}&";
      }
    });

    String cuisineTypeStr = "";
    cuisineType.forEach((key, value) {
      if(value.check == true) {
        cuisineTypeStr += "cuisineType=${value.apiParameter}&";
      }
    });

    String typeMealStr = "";
    typeMeal.forEach((key, value) {
      if(value.check == true){
        typeMealStr += "mealType=${value.apiParameter}&";
      }
    });

    String dishTypeStr = "";
    dishType.forEach((key, value) {
      if(value.check == true){
        dishTypeStr += "dishType=${value.apiParameter}&";
      }
    });

    var response = await http
        .get(Uri.parse("https://api.edamam.com/api/recipes/v2?type=public&"
            "app_id=$recipeAppID&"
            "app_key=$recipeAppKey&"
            "$dietsStr"
            "$healthStr"
            "$cuisineTypeStr"
            "$typeMealStr"
            "$dishTypeStr"));

    print("Статус запроса: ${response.statusCode}");

    if(response.statusCode == 200){
      return _parseJsonToList(response.body);
    }else{
      return [];
    }

    // Подгрузка с файла
    // var directory = await getApplicationDocumentsDirectory();
    // var file = File("${directory.path}/recipe.json");
    //
    // String temp = await file.readAsString();
    // return _parseJsonToList(temp);
  }


  static Future<List<Recipe>> _parseJsonToList(String jsonStr) async {
    List<Recipe> list = [];
    final jsonData = json.decode(jsonStr);

    for(var recipe in jsonData["hits"]){
      Map<String, dynamic> data = recipe["recipe"];
      List<Nutrient> totalNutrients = [];
      data["totalNutrients"].forEach((key, value) {
        totalNutrients.add(Nutrient.fromMapOnAPI(key, value));
      });

      String idRecipe = data["uri"].split("recipe_")[1];
      Recipe recipeDB = await DBProvider.db.getRecipe(idRecipe);

      list.add(Recipe(
              id: idRecipe,
              favorite: recipeDB.id != "",
              label: data["label"],
              image: data["image"],
              source: data["source"],
              dietLabels: data["dietLabels"].cast<String>(),
              healthLabels: data["healthLabels"].cast<String>(),
              cautions: data["cautions"].cast<String>(),
              ingredientLines: data["ingredientLines"].cast<String>(),
              ingredients: data["ingredients"].map((ingredient) => Ingredient.fromMapOnAPI(ingredient)).toList().cast<Ingredient>(),
              calories: data["calories"].toDouble(),
              totalWeight: data["totalWeight"].toDouble(),
              totalTime: data["totalTime"].toDouble(),
              cuisineType: data["cuisineType"].cast<String>(),
              mealType: data["mealType"].cast<String>(),
              dishType: data["dishType"].cast<String>(),
              totalNutrients: totalNutrients
          ));
    }

    return list;
  }
}
