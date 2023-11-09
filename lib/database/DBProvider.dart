import 'dart:developer';
import 'dart:io';

import 'package:nutrition_assistant/models/control_point.dart';
import 'package:nutrition_assistant/models/food/serving_size.dart';
import 'package:nutrition_assistant/models/meal.dart';
import 'package:nutrition_assistant/models/food/food.dart';
import 'package:nutrition_assistant/models/food/measure.dart';
import 'package:nutrition_assistant/models/food/nutrients.dart';
import 'package:nutrition_assistant/models/performance/checkbox.dart';
import 'package:nutrition_assistant/models/recipe/ingredient.dart';
import 'package:nutrition_assistant/models/recipe/nutrient.dart';
import 'package:nutrition_assistant/models/recipe/recipe.dart';
import 'package:nutrition_assistant/models/target.dart';
import 'package:nutrition_assistant/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "nutrition_assistant.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          //Таблица для хранения данных пользователя
          await db.execute(User.createSQL);
          //Таблица для хранения данных о цели пользователя
          await db.execute(Target.createSQL);
          //Таблица для хранения данных о контрольной точки веса пользователя
          await db.execute(ControlPoint.createSQL);
          //Таблица для хранения данных о рецептах
          await db.execute(Recipe.createSQL);
          //Таблица для хранения данных ингридиентов для рецептов
          await db.execute(Ingredient.createSQL);
          //Таблица для хранения данных о пищевой ценности для рецептов
          await db.execute(Nutrient.createSQL);
          //Таблица для хранения данных о продуктах
          await db.execute(Food.createSQL);
          //Таблица для хранения данных о пищевой ценности для продукта
          await db.execute(Nutrients.createSQL);
          //Таблица для хранения данных о мере измерения для продукта
          await db.execute(Measure.createSQL);
          //Таблица для хранения данных о размере порции для продукта
          await db.execute(ServingSizes.createSQL);
          //Таблица для хранения данных о приеме пищи
          await db.execute(Meal.createSQL);
        });
  }

  /*
  INSERT
   */

  newUserObj(User user) async {
    String dateOfBirthString = user.dateOfBirth.toString();
    int genderInt = user.gender == Gender.man ? 2 : 1;

    final db = await database;
    var raw = await db!.rawInsert(
        "INSERT INTO User (Username, Gender, Weight, Height, DateOfBirth) "
        "VALUES (?, ?, ?, ?, ?)",
        [user.username, genderInt, user.weight, user.height, dateOfBirthString]);

    log("Добавлена запись о пользователе "
        "username: ${user.username}, gender: ${user.gender}, weight: ${user.weight}, "
        "height: ${user.height}, dateOfBirth: $dateOfBirthString");
    return raw;
  }

  newTargetObj(Target target) async {
    int typeInt;
    switch(target.type){
      case TypeTarget.loseWeight:
        typeInt = 0;
        break;
      case TypeTarget.holdWeight:
        typeInt = 1;
        break;
      case TypeTarget.gainWeight:
        typeInt = 2;
        break;
    }

    final db = await database;
    var raw = await db!.rawInsert(
        "INSERT INTO Target (UserId, Type, TargetWeight, Tempo) "
            "VALUES (?, ?, ?, ?)",
        [1, typeInt, target.targetWeight, target.tempo]);

    log("Добавлена запись о целе пользователя"
        "UserId: 1, Type: $typeInt, TargetWeight: ${target.targetWeight}, "
        "Tempo: ${target.tempo}");
    return raw;
  }

  newControlPointParams(int userId, int targetId,
      int weight, DateTime dateTime) async {
    final db = await database;
    var raw = await db!.rawInsert(
        "INSERT INTO ControlPoint (UserId, TargetId, Weight, DateTime) "
            "VALUES (?, ?, ?, ?)", [1, 1, weight, dateTime.toString()]);

    log("Добавлена запись о контрольной точке"
        "UserId: 1, TargetId: 1, Weight: $weight, DateTime: ${dateTime.toString()}");
    return raw;
  }

  newFoodObj(Food food) async {
    final db = await database;
    var rawFood = await db!.rawInsert(
        "INSERT INTO Food (Id, Label, KnownAs, Brand, Category, CategoryLabel, Image, ServingsPerContainer) "
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
        [food.id, food.label, food.knownAs, food.brand, food.category,
          food.categoryLabel, food.image, food.servingsPerContainer]);

    Nutrients nutrients = food.nutrients;
    var rawNutr = await db.rawInsert(
        "INSERT INTO Nutrients (ProductId, ENERCKCAL, PROCNT, FAT, CHOCDF, FIBTG)"
            "VALUES (?, ?, ?, ?, ?, ?)",
        [food.id, nutrients.enercKCal, nutrients.procnt,
          nutrients.fat, nutrients.chocdf, nutrients.fibig]
    );

    ServingSizes servingSizes = food.servingSizes;
    var rawServSize = await db.rawInsert(
        "INSERT INTO ServingSize (ProductId, URI, Label, Quantity) VALUES (?, ?, ?, ?)",
        [food.id, servingSizes.uri, servingSizes.label, servingSizes.quantity]
    );

    for(var measure in food.measures){
      var rawMeas = await db.rawInsert(
        "INSERT INTO Measure (ProductId, URI, Label, Weight) VALUES (?, ?, ?, ?)",
          [food.id, measure.uri, measure.label, measure.weight]
      );
    }

    log("Добавлена запись о продукте"
        "Id: ${food.id}, Label: ${food.label}, KnownAs: ${food.knownAs}, "
        "Category: ${food.category}, CategoryLabel: ${food.categoryLabel}");

    return rawFood;
  }

  newRecipeObj(Recipe recipe) async {
    final db = await database;

    var rawRec = await db!.rawInsert(
        "INSERT INTO Recipe (Id, Label, Image, Source, DietLabels, HealthLabels, Cautions, "
            "IngredientLines, Calories, TotalWeight, TotalTime, CuisineType, MealType, DishType)"
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [recipe.id, recipe.label, recipe.image, recipe.source,
          recipe.parseListToString(recipe.dietLabels),
          recipe.parseListToString(recipe.healthLabels),
          recipe.parseListToString(recipe.cautions),
          recipe.parseListToString(recipe.ingredientLines),
          recipe.calories, recipe.totalWeight, recipe.totalTime,
          recipe.parseListToString(recipe.cuisineType),
          recipe.parseListToString(recipe.mealType),
          recipe.parseListToString(recipe.dishType)
        ]);

    for(var ingredient in recipe.ingredients){
      var rawIngr = await db.rawInsert(
          "INSERT INTO Ingredient (RecipeId, Text, Quantity, Measure, Food, Weight, FoodCategory, FoodId, Image)"
              "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
          [recipe.id, ingredient.text, ingredient.quantity, ingredient.measure, ingredient.food,
            ingredient.weight, ingredient.foodCategory, ingredient.foodId, ingredient.image]
      );
    }

    for(var nutrient in recipe.totalNutrients){
      var rawNutr = await db.rawInsert(
          "INSERT INTO Nutrient (RecipeId, TotalLabel, Label, Quantity, Unit)"
              "VALUES (?, ?, ?, ?, ?)",
          [recipe.id, nutrient.totalLabel, nutrient.label, nutrient.quantity, nutrient.unit]
      );
    }

    log("Добавлена запись о рецепте Id: ${recipe.id}, Label: ${recipe.label}");
    return rawRec;
  }

  newMealParams(String name, DateTime dateTime, double calories) async{
    final db = await database;
    var raw = await db!.rawInsert(
      "INSERT INTO Meal (Name, DateTime, Calories) VALUES (?, ?, ?)",
        [name, dateTime.toString(), calories]);

    log("Добавлена запись о приеме пищи Name: ${name}");
    return raw;
  }

  /*
  SELECT
   */

  Future<User> getUser() async {
    final db = await database;
    var res = await db!.query("User", where: "id = ?", whereArgs: [1]);
    log("Получена запись пользователя");
    return res.isEmpty ? getEmptyUser() : User.fromMap(res.first);
  }

  Future<Target> getTarget() async {
    final db = await database;
    var res = await db!.query("Target", where: "UserId = ?", whereArgs: [1]);
    log("Получена запись о цели пользователя");
    return res.isEmpty ? getEmptyTarget() : Target.fromMap(res.first);
  }

  Future<ControlPoint> getLastControlPoint() async {
    final db = await database;
    var res = await db!.query("ControlPoint");
    List<ControlPoint> list = res.isNotEmpty ?
    res.map((point) => ControlPoint.fromMap(point)).toList() : [];
    log("Получено ${list.length} записей о контрольных точках");
    return list.isEmpty ? getEmptyControlPoint() : list.last;
  }

  Future<List<ControlPoint>> getControlPoints() async {
    final db = await database;
    var res = await db!.query("ControlPoint");
    List<ControlPoint> list = res.isNotEmpty ?
        res.map((point) => ControlPoint.fromMap(point)).toList() : [];
    log("Получено ${list.length} записей о контрольных точках");
    return list;
  }

  Future<Food> getFood(String id) async{
    final db = await database;
    var res = await db!.query("Food", where: "Id = ?", whereArgs: [id]);
    log("Получена запись о продукте с id: ${id}");
    return res.isEmpty ? getEmptyFood() : Food.fromMapDB(null, null, null, res.first);
  }

  Future<List<Food>> getFoodAll() async{
    final db = await database;
    var resFoods = await db!.query("Food");

    List<Food> listFoods = [];
    if(resFoods.isNotEmpty){
      for(var food in resFoods){
        var resNutr = await db.query("Nutrients", where: "ProductId = ?", whereArgs: [food["Id"]]);
        Nutrients nutrients = Nutrients.fromMap(resNutr.first);

        var resMeas = await db.query("Measure", where: "ProductId = ?", whereArgs: [food["Id"]]);
        List<Measure> listMeas = resMeas.isNotEmpty ? resMeas.map((measure) => Measure.fromMap(measure)).toList() : [];

        var resServSize = await db.query("ServingSize", where: "ProductId = ?", whereArgs: [food["Id"]]);
        ServingSizes servingSizes = ServingSizes.fromMap(resServSize.first);

        listFoods = resFoods.map((food) => Food.fromMapDB(nutrients, listMeas, servingSizes, food)).toList();
      }
    }

    log("Получено ${listFoods.length} записей о всех продуктах");
    return listFoods;
  }

  Future<Recipe> getRecipe(String id) async{
    final db = await database;
    var res = await db!.query("Recipe", where: "Id = ?", whereArgs: [id]);
    log("Получена запись о рецепте с id: ${id}");
    return res.isEmpty ? getEmptyRecipe() : Recipe.fromMapOnDB(null, null, res.first);
  }

  Future<List<Recipe>> getFilterRecipes({required Map<int, CheckBox> diets,
    required Map<int, CheckBox> health, required Map<int, CheckBox> cuisineType,
    required Map<int, CheckBox> typeMeal, required Map<int, CheckBox> dishType}) async{

    String dietsStr = "";
    diets.forEach((key, value) {
      if(value.check == true){
        dietsStr += "DietLabels LIKE '%${value.techName}%' OR ";
      }
    });

    String healthStr = "";
    health.forEach((key, value) {
      if(value.check == true){
        healthStr += "HealthLabels LIKE '%${value.techName}%' OR ";
      }
    });

    String cuisineTypeStr = "";
    cuisineType.forEach((key, value) {
      if(value.check == true) {
        cuisineTypeStr += "CuisineType LIKE '%${value.techName}%' OR ";
      }
    });

    String typeMealStr = "";
    typeMeal.forEach((key, value) {
      if(value.check == true){
        typeMealStr += "MealType LIKE '%${value.techName}%' OR ";
      }
    });

    String dishTypeStr = "";
    dishType.forEach((key, value) {
      if(value.check == true){
        dishTypeStr += "DishType LIKE '%${value.techName}%' OR ";
      }
    });

    List<String> listFilter = [dietsStr, healthStr, cuisineTypeStr, typeMealStr, dishTypeStr];
    listFilter.removeWhere((element) => element == "");

    List<Recipe> listRec = [];
    if(listFilter.isNotEmpty){

      String sql = "SELECT * FROM Recipe WHERE ";
      for(var filter in listFilter){
        sql += "${filter.replaceRange(filter.length-3, filter.length, "")} OR ";
      }

      final db = await database;
      var resRec = await db!.rawQuery(sql.replaceRange(sql.length-4, sql.length, ""));

      if(resRec.isNotEmpty){
        for(var recipe in resRec){
          var resIngr = await db.query("Ingredient", where: "RecipeId = ?", whereArgs: [recipe["Id"]]);
          List<Ingredient> listIngr = resIngr.isNotEmpty
              ? resIngr.map((ingredient) => Ingredient.fromMapOnDB(ingredient)).toList() : [];

          var resNutr = await db.query("Nutrient", where: "RecipeId = ?", whereArgs: [recipe["Id"]]);
          List<Nutrient> listNutr = resNutr.isNotEmpty
              ? resNutr.map((nutrient) => Nutrient.fromMapOnDB(nutrient)).toList() : [];

          listRec = resRec.map((recipe) => Recipe.fromMapOnDB(listIngr, listNutr, recipe)).toList();
        }
      }
    }

    return listRec;
  }

  Future<List<Recipe>> getAllRecipes() async{
    List<Recipe> listRec = [];
    final db = await database;
    var resRec = await db!.query("Recipe");

    if(resRec.isNotEmpty){
      for(var recipe in resRec){
        var resIngr = await db.query("Ingredient", where: "RecipeId = ?", whereArgs: [recipe["Id"]]);
        List<Ingredient> listIngr = resIngr.isNotEmpty
            ? resIngr.map((ingredient) => Ingredient.fromMapOnDB(ingredient)).toList() : [];

        var resNutr = await db.query("Nutrient", where: "RecipeId = ?", whereArgs: [recipe["Id"]]);
        List<Nutrient> listNutr = resNutr.isNotEmpty
            ? resNutr.map((nutrient) => Nutrient.fromMapOnDB(nutrient)).toList() : [];

        listRec = resRec.map((recipe) => Recipe.fromMapOnDB(listIngr, listNutr, recipe)).toList();
      }
    }

    return listRec;
  }
  
  Future<List<Meal>> getAllMeal() async {
    final db = await database;
    var res = await db!.query("Meal");
    List<Meal> list = res.isNotEmpty ? res.map((meal) => Meal.fromMap(meal)).toList() : [];
    log("Получено ${list.length} записей о приемах пищи");
    return list;
  }

  /*
  DELETE
   */
  deleteRecipe(String id) async {
    final db = await database;
    db!.delete("Ingredient", where: "RecipeId = ?", whereArgs: [id]);
    db.delete("Nutrient", where: "RecipeId = ?", whereArgs: [id]);
    return db.delete("Recipe", where: "Id = ?", whereArgs: [id]);
  }

  deleteFood(String id) async {
    final db = await database;
    db!.delete("Nutrients", where: "ProductId = ?", whereArgs: [id]);
    db.delete("Measure", where: "ProductId = ?", whereArgs: [id]);
    db.delete("ServingSize", where: "ProductId = ?", whereArgs: [id]);
    return db.delete("Food", where: "Id = ?", whereArgs: [id]);
  }
  
  deleteUser() async{
    final db = await database;
    db!.rawDelete("DELETE FROM User");
    db.rawDelete("DELETE FROM Target");
    db.rawDelete("DELETE FROM ControlPoint");
  }

  /*
  UPDATE
   */

  Future<int> changeTarget(int typeTarget, int targetWeight, double tempo) async{
    final db = await database;
    var raw = db!.rawUpdate("UPDATE Target SET Type = ?, TargetWeight = ?, Tempo = ? WHERE UserId = ?",
        [typeTarget, targetWeight, tempo, 1]);
    log("Изменена запись о целе пользователя");
    return raw;
  }
}

