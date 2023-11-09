import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nutrition_assistant/core/api_keys.dart';
import 'package:nutrition_assistant/models/food/food.dart';

class NutrientsAPI{
  static Future<double> getCalories(List<Food> foods) async{

    double totalCalories = 0;

    for(var food in foods){
      var response = await http.post(
        Uri.parse("https://api.edamam.com/api/food-database/v2/nutrients?"
            "app_id=$foodAppID&"
            "app_key=$foodAppKey"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: foodToJson(food)
      );

      print("Статус запроса: ${response.statusCode}");

      final jsonData = json.decode(response.body);
      totalCalories += jsonData['calories'];
    }

    return totalCalories;
  }
}