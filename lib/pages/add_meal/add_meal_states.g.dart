// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_meal_states.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddMealStates on _AddMealStates, Store {
  late final _$typePageAtom =
      Atom(name: '_AddMealStates.typePage', context: context);

  @override
  TypePage get typePage {
    _$typePageAtom.reportRead();
    return super.typePage;
  }

  @override
  set typePage(TypePage value) {
    _$typePageAtom.reportWrite(value, super.typePage, () {
      super.typePage = value;
    });
  }

  late final _$foodsAtom = Atom(name: '_AddMealStates.foods', context: context);

  @override
  ObservableFuture<List<Food>> get foods {
    _$foodsAtom.reportRead();
    return super.foods;
  }

  @override
  set foods(ObservableFuture<List<Food>> value) {
    _$foodsAtom.reportWrite(value, super.foods, () {
      super.foods = value;
    });
  }

  late final _$foodsAPIAtom =
      Atom(name: '_AddMealStates.foodsAPI', context: context);

  @override
  ObservableFuture<List<Food>> get foodsAPI {
    _$foodsAPIAtom.reportRead();
    return super.foodsAPI;
  }

  @override
  set foodsAPI(ObservableFuture<List<Food>> value) {
    _$foodsAPIAtom.reportWrite(value, super.foodsAPI, () {
      super.foodsAPI = value;
    });
  }

  late final _$foodsDBAtom =
      Atom(name: '_AddMealStates.foodsDB', context: context);

  @override
  ObservableFuture<List<Food>> get foodsDB {
    _$foodsDBAtom.reportRead();
    return super.foodsDB;
  }

  @override
  set foodsDB(ObservableFuture<List<Food>> value) {
    _$foodsDBAtom.reportWrite(value, super.foodsDB, () {
      super.foodsDB = value;
    });
  }

  late final _$foodsTotalAtom =
      Atom(name: '_AddMealStates.foodsTotal', context: context);

  @override
  ObservableFuture<List<Food>> get foodsTotal {
    _$foodsTotalAtom.reportRead();
    return super.foodsTotal;
  }

  @override
  set foodsTotal(ObservableFuture<List<Food>> value) {
    _$foodsTotalAtom.reportWrite(value, super.foodsTotal, () {
      super.foodsTotal = value;
    });
  }

  late final _$selectFoodAtom =
      Atom(name: '_AddMealStates.selectFood', context: context);

  @override
  Food? get selectFood {
    _$selectFoodAtom.reportRead();
    return super.selectFood;
  }

  @override
  set selectFood(Food? value) {
    _$selectFoodAtom.reportWrite(value, super.selectFood, () {
      super.selectFood = value;
    });
  }

  late final _$showSelectFoodNutrientsAtom =
      Atom(name: '_AddMealStates.showSelectFoodNutrients', context: context);

  @override
  bool get showSelectFoodNutrients {
    _$showSelectFoodNutrientsAtom.reportRead();
    return super.showSelectFoodNutrients;
  }

  @override
  set showSelectFoodNutrients(bool value) {
    _$showSelectFoodNutrientsAtom
        .reportWrite(value, super.showSelectFoodNutrients, () {
      super.showSelectFoodNutrients = value;
    });
  }

  late final _$focusNameMealAtom =
      Atom(name: '_AddMealStates.focusNameMeal', context: context);

  @override
  FocusNode get focusNameMeal {
    _$focusNameMealAtom.reportRead();
    return super.focusNameMeal;
  }

  @override
  set focusNameMeal(FocusNode value) {
    _$focusNameMealAtom.reportWrite(value, super.focusNameMeal, () {
      super.focusNameMeal = value;
    });
  }

  late final _$focusNameFoodAtom =
      Atom(name: '_AddMealStates.focusNameFood', context: context);

  @override
  FocusNode get focusNameFood {
    _$focusNameFoodAtom.reportRead();
    return super.focusNameFood;
  }

  @override
  set focusNameFood(FocusNode value) {
    _$focusNameFoodAtom.reportWrite(value, super.focusNameFood, () {
      super.focusNameFood = value;
    });
  }

  late final _$dateMealAtom =
      Atom(name: '_AddMealStates.dateMeal', context: context);

  @override
  DateTime? get dateMeal {
    _$dateMealAtom.reportRead();
    return super.dateMeal;
  }

  @override
  set dateMeal(DateTime? value) {
    _$dateMealAtom.reportWrite(value, super.dateMeal, () {
      super.dateMeal = value;
    });
  }

  late final _$measureLabelAtom =
      Atom(name: '_AddMealStates.measureLabel', context: context);

  @override
  String? get measureLabel {
    _$measureLabelAtom.reportRead();
    return super.measureLabel;
  }

  @override
  set measureLabel(String? value) {
    _$measureLabelAtom.reportWrite(value, super.measureLabel, () {
      super.measureLabel = value;
    });
  }

  late final _$_AddMealStatesActionController =
      ActionController(name: '_AddMealStates', context: context);

  @override
  void getFoodsOnAPI() {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.getFoodsOnAPI');
    try {
      return super.getFoodsOnAPI();
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fillByType() {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.fillByType');
    try {
      return super.fillByType();
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cleanFoodTotal() {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.cleanFoodTotal');
    try {
      return super.cleanFoodTotal();
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addFoodTotal() {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.addFoodTotal');
    try {
      return super.addFoodTotal();
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delFoodTotal() {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.delFoodTotal');
    try {
      return super.delFoodTotal();
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeOnAddFood() {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.changeOnAddFood');
    try {
      return super.changeOnAddFood();
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeOnAddMeal() {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.changeOnAddMeal');
    try {
      return super.changeOnAddMeal();
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFavorite() {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.changeFavorite');
    try {
      return super.changeFavorite();
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fillSelectFood(int index) {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.fillSelectFood');
    try {
      return super.fillSelectFood(index);
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeShowNutrients() {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.changeShowNutrients');
    try {
      return super.changeShowNutrients();
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void hideKeyBoard(bool visible) {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.hideKeyBoard');
    try {
      return super.hideKeyBoard(visible);
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeDateMeal(DateTime calendar) {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.changeDateMeal');
    try {
      return super.changeDateMeal(calendar);
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeMeasureLabel(String value) {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.changeMeasureLabel');
    try {
      return super.changeMeasureLabel(value);
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeMeasureSelectFood() {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.changeMeasureSelectFood');
    try {
      return super.changeMeasureSelectFood();
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectFood() {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.changeSelectFood');
    try {
      return super.changeSelectFood();
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFavoriteFoodIndex(int index) {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.changeFavoriteFoodIndex');
    try {
      return super.changeFavoriteFoodIndex(index);
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFavoriteFoodId(String id) {
    final _$actionInfo = _$_AddMealStatesActionController.startAction(
        name: '_AddMealStates.changeFavoriteFoodId');
    try {
      return super.changeFavoriteFoodId(id);
    } finally {
      _$_AddMealStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
typePage: ${typePage},
foods: ${foods},
foodsAPI: ${foodsAPI},
foodsDB: ${foodsDB},
foodsTotal: ${foodsTotal},
selectFood: ${selectFood},
showSelectFoodNutrients: ${showSelectFoodNutrients},
focusNameMeal: ${focusNameMeal},
focusNameFood: ${focusNameFood},
dateMeal: ${dateMeal},
measureLabel: ${measureLabel}
    ''';
  }
}
