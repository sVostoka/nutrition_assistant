import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nutrition_assistant/core/api_keys.dart';
import 'package:nutrition_assistant/database/DBProvider.dart';
import 'package:nutrition_assistant/models/food/food.dart';
import 'package:nutrition_assistant/models/food/measure.dart';
import 'package:nutrition_assistant/models/food/nutrients.dart';
import 'package:nutrition_assistant/models/food/serving_size.dart';

class FoodAPI{
  static Future<List<Food>> getFoods(String searchName) async{

    var response = await http
        .get(Uri.parse("https://api.edamam.com/api/food-database/v2/parser?"
        "app_id=$foodAppID&"
        "app_key=$foodAppKey&"
        "ingr=$searchName&"
        "nutrition-type=cooking"));

    print("Статус запроса: ${response.statusCode}");

    if(response.statusCode == 200){
      return _parseJsonToList(response.body);
    }else{
      return [];
    }

    // Подгрузка с файла
    // var directory = await getApplicationDocumentsDirectory();
    // var file = File("${directory.path}/foods.json");
    // String temp = await file.readAsString();
    //
    // return _parseJsonToList(temp);
  }

  static Future<List<Food>> _parseJsonToList(String jsonStr) async{
    List<Food> list = [];
    final jsonData = json.decode(jsonStr);

    for(var food in jsonData["hints"]){
      var dataFood = food["food"];
      var dataNutrients = dataFood["nutrients"];
      var dataServingSizes = dataFood["servingSizes"];
      var dataMeasures = food["measures"];

      String foodId = dataFood["foodId"].split("food_")[1];
      Food foodDB = await DBProvider.db.getFood(foodId);

      List<Measure> measures = [];
      for(var measure in dataMeasures){
        measures.add(Measure(
            productId: foodId,
            uri: measure["uri"],
            label: measure["label"],
            weight: measure["weight"].toDouble()));
      }

      list.add(Food(
          id: foodId,
          favorite: foodDB.id != "",
          label: dataFood["label"],
          knownAs: dataFood["knownAs"],
          brand: dataFood["brand"] ?? "",
          category: dataFood["category"],
          categoryLabel: dataFood["categoryLabel"],
          image: dataFood["image"] ?? "",
          servingsPerContainer: dataFood["servingsPerContainer"] == null ? 0 : dataFood["servingsPerContainer"].toDouble(),
          measures: measures,
          servingSizes: dataServingSizes == null ? getEmptyServingSize() : ServingSizes(
              productId: foodId,
              uri: dataServingSizes[0]["uri"],
              label: dataServingSizes[0]["label"],
              quantity: dataServingSizes[0]["quantity"].toDouble()),
          nutrients: Nutrients(
              productId: foodId,
              enercKCal: dataNutrients["ENERC_KCAL"] == null ? 0 : dataNutrients["ENERC_KCAL"].toDouble(),
              procnt: dataNutrients["PROCNT"] == null ? 0 : dataNutrients["PROCNT"].toDouble(),
              fat: dataNutrients["FAT"] == null ? 0 : dataNutrients["FAT"].toDouble(),
              chocdf: dataNutrients["CHOCDF"] == null ? 0 : dataNutrients["CHOCDF"].toDouble(),
              fibig: dataNutrients["FIBTG"] == null ? 0 : dataNutrients["FIBTG"].toDouble())
          ));
    }

    return list;
  }
}