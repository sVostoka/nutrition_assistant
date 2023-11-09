import 'dart:convert';

import 'package:nutrition_assistant/models/food/measure.dart';
import 'package:nutrition_assistant/models/food/nutrients.dart';
import 'package:nutrition_assistant/models/food/serving_size.dart';

String foodToJson(Food data) {
  final dyn = data.toMapAPI();
  return json.encode(dyn);
}

Food getEmptyFood(){
  return Food(
      id: "",
      label: "",
      knownAs: "",
      nutrients: getEmptyNutrients(),
      category: "",
      categoryLabel: "",
      measures: [],
      brand: "",
      image: "",
      servingsPerContainer: 0,
      servingSizes: getEmptyServingSize());
}

class Food{
  final String id;
  bool favorite;
  final String label;
  final String knownAs;
  final String brand;
  final Nutrients nutrients;
  final String category;
  final String categoryLabel;
  final String image;
  final List<Measure> measures;
  final double servingsPerContainer;
  final ServingSizes servingSizes;
  int count;
  Measure? measureCount;

  static String createSQL =
      "CREATE TABLE Food ("
        "Id	TEXT NOT NULL UNIQUE,"
        "Label TEXT, "
        "KnownAs TEXT, "
        "Brand TEXT, "
        "Category TEXT, "
        "CategoryLabel TEXT, "
        "Image TEXT, "
        "ServingsPerContainer REAL, "
        "PRIMARY KEY(Id)"
      ");";

  Food({
    required this.id,
    this.favorite = false,
    required this.label,
    required this.knownAs,
    required this.brand,
    required this.nutrients,
    required this.category,
    required this.categoryLabel,
    required this.image,
    required this.measures,
    required this.servingsPerContainer,
    required this.servingSizes,
    this.count = 0,
    this.measureCount
  });

  factory Food.fromMapDB(Nutrients? nutrients, List<Measure>? measures,
      ServingSizes? servingSizes, Map<String, dynamic> json) => Food(
    id: json["Id"],
    favorite: true,
    label: json["Label"],
    knownAs: json["KnownAs"],
    brand: json["Brand"],
    nutrients: nutrients ?? getEmptyNutrients(),
    category: json["Category"],
    categoryLabel: json["CategoryLabel"],
    image: json["Image"],
    measures: measures ?? [],
    servingsPerContainer: json["ServingsPerContainer"],
    servingSizes: servingSizes ?? getEmptyServingSize(),
  );

  Map<String, List<Map<String, dynamic>>> toMapAPI() => {
  "ingredients":[
    {
      "quantity": count,
      "measureURI": measureCount!.uri,
      "foodId": "food_$id"
    }
  ]
  };
}