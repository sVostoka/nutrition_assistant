import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrition_assistant/database/DBProvider.dart';
import 'package:nutrition_assistant/models/food/food.dart';
import 'package:nutrition_assistant/network/food_api.dart';

part 'add_meal_states.g.dart';

class AddMealStates = _AddMealStates with _$AddMealStates;

abstract class _AddMealStates with Store{

  @observable
  TypePage typePage = TypePage.addMeal;

  @observable
  ObservableFuture<List<Food>> foods = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Food>> foodsAPI = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Food>> foodsDB = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Food>> foodsTotal = ObservableFuture.value([]);

  @action
  void getFoodsOnAPI(){
    foodsAPI = ObservableFuture(FoodAPI.getFoods(textControllerNameFood.text));
  }

  @action
  void fillByType(){
    if(typePage == TypePage.favorite){
      foodsDB = ObservableFuture(DBProvider.db.getFoodAll());
      foods = foodsDB;
    }

    if(typePage == TypePage.addFood){
      foods = foodsAPI;
    }

    if(typePage == TypePage.addMeal){
      foods = foodsTotal;
    }
  }

  @action
  void cleanFoodTotal(){
    foodsTotal = ObservableFuture.value([]);
  }

  @action
  void addFoodTotal(){
    foodsTotal = ObservableFuture(addFutureList());
  }

  @action
  void delFoodTotal(){
    foodsTotal = ObservableFuture(delFutureList());
  }

  Future<List<Food>> addFutureList() async{
    List<Food> list = foodsTotal.value ?? [];
    if(textControllerCountFood.text != "") {
      changeMeasureSelectFood();
      list.add(selectFood!);
    }
    return list;
  }

  Future<List<Food>> delFutureList() async{
    List<Food> list = foodsTotal.value ?? [];
    if(list.isNotEmpty) {
      list.remove(selectFood!);
    }
    return list;
  }

  @action
  void changeOnAddFood(){
    typePage = TypePage.addFood;
  }

  @action
  void changeOnAddMeal(){
    typePage = TypePage.addMeal;
  }

  @action
  void changeFavorite(){
    if(typePage == TypePage.addFood){
      typePage = TypePage.favorite;
    }else{
      typePage = TypePage.addFood;
    }
  }

  @observable
  Food? selectFood;

  @action
  void fillSelectFood(int index){
    if(typePage == TypePage.favorite) {
      selectFood = foodsDB.value![index];
    }

    if(typePage == TypePage.addMeal){
      selectFood = foodsTotal.value![index];
    }

    if(typePage == TypePage.addFood){
      selectFood = foodsAPI.value![index];
    }
  }

  @observable
  bool showSelectFoodNutrients = false;

  @action
  void changeShowNutrients(){
    showSelectFoodNutrients = !showSelectFoodNutrients;
  }

  @observable
  var focusNameMeal = FocusNode();

  @observable
  var focusNameFood = FocusNode();

  @action
  void hideKeyBoard(bool visible){
    if(visible == false) {
      focusNameMeal.unfocus();
      focusNameFood.unfocus();
    }
  }

  @observable
  DateTime? dateMeal;

  @action
  void changeDateMeal(DateTime calendar){
    dateMeal = calendar;
  }

  @observable
  String? measureLabel;

  @action
  void changeMeasureLabel(String value){
    measureLabel = value;
  }

  @action
  void changeMeasureSelectFood(){
    measureLabel = measureLabel ?? selectFood!.measures.first.label;

    selectFood = Food(
        id: selectFood!.id,
        favorite: selectFood!.favorite,
        label: selectFood!.label,
        knownAs: selectFood!.knownAs,
        brand: selectFood!.brand,
        nutrients: selectFood!.nutrients,
        category: selectFood!.category,
        categoryLabel: selectFood!.categoryLabel,
        image: selectFood!.image,
        measures: selectFood!.measures,
        servingsPerContainer: selectFood!.servingsPerContainer,
        servingSizes: selectFood!.servingSizes,
        measureCount: selectFood!.measures.where((element) =>
          element.label == measureLabel).first,
        count: int.parse(textControllerCountFood.text == ""
            ? "0" : textControllerCountFood.text)
    );
  }

  @action
  void changeSelectFood(){
    selectFood = Food(
        id: selectFood!.id,
        favorite: !selectFood!.favorite,
        label: selectFood!.label,
        knownAs: selectFood!.knownAs,
        brand: selectFood!.brand,
        nutrients: selectFood!.nutrients,
        category: selectFood!.category,
        categoryLabel: selectFood!.categoryLabel,
        image: selectFood!.image,
        measures: selectFood!.measures,
        servingsPerContainer: selectFood!.servingsPerContainer,
        servingSizes: selectFood!.servingSizes);
  }

  @action
  void changeFavoriteFoodIndex(int index){
    foods = ObservableFuture(getChangeListIndex(index));
  }

  Future<List<Food>> getChangeListIndex(int index) async{
    List<Food> list = foodsAPI.value ?? [];

    list[index] = Food(
        id: list[index].id,
        favorite: !list[index].favorite,
        label: list[index].label,
        knownAs: list[index].knownAs,
        brand: list[index].brand,
        nutrients: list[index].nutrients,
        category: list[index].category,
        categoryLabel: list[index].categoryLabel,
        image: list[index].image,
        measures: list[index].measures,
        servingsPerContainer: list[index].servingsPerContainer,
        servingSizes: list[index].servingSizes);
    return list;
  }

  @action
  void changeFavoriteFoodId(String id){
    foods = ObservableFuture(getChangeListAPIId(id));
    foodsTotal = ObservableFuture(getChangeListTotalId(id));
  }

  Future<List<Food>> getChangeListTotalId(String id) async{
    List<Food> list = foodsTotal.value ?? [];

    list.asMap().forEach((index, food) {
      if(food.id == id){
        list[index] = Food(
            id: list[index].id,
            favorite: !list[index].favorite,
            label: list[index].label,
            knownAs: list[index].knownAs,
            brand: list[index].brand,
            nutrients: list[index].nutrients,
            category: list[index].category,
            categoryLabel: list[index].categoryLabel,
            image: list[index].image,
            measures: list[index].measures,
            servingsPerContainer: list[index].servingsPerContainer,
            servingSizes: list[index].servingSizes,
            count: list[index].count,
            measureCount: list[index].measureCount
        );
      }
    });

    return list;
  }

  Future<List<Food>> getChangeListAPIId(String id) async{
    List<Food> list = foodsAPI.value ?? [];

    list.asMap().forEach((index, food) {
      if(food.id == id){
        list[index] = Food(
            id: list[index].id,
            favorite: !list[index].favorite,
            label: list[index].label,
            knownAs: list[index].knownAs,
            brand: list[index].brand,
            nutrients: list[index].nutrients,
            category: list[index].category,
            categoryLabel: list[index].categoryLabel,
            image: list[index].image,
            measures: list[index].measures,
            servingsPerContainer: list[index].servingsPerContainer,
            servingSizes: list[index].servingSizes
        );
      }
    });

    return list;
  }

  var textControllerNameFood = TextEditingController();
  var textControllerNameMeal = TextEditingController();
  var textControllerCountFood = TextEditingController();
  var keyboardVisibilityController = KeyboardVisibilityController();
}

enum TypePage{
  favorite,
  addFood,
  addMeal
}