// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookbook_states.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CookBookStates on _CookBookStates, Store {
  late final _$favoriteAtom =
      Atom(name: '_CookBookStates.favorite', context: context);

  @override
  bool get favorite {
    _$favoriteAtom.reportRead();
    return super.favorite;
  }

  @override
  set favorite(bool value) {
    _$favoriteAtom.reportWrite(value, super.favorite, () {
      super.favorite = value;
    });
  }

  late final _$recipesAtom =
      Atom(name: '_CookBookStates.recipes', context: context);

  @override
  ObservableFuture<List<Recipe>> get recipes {
    _$recipesAtom.reportRead();
    return super.recipes;
  }

  @override
  set recipes(ObservableFuture<List<Recipe>> value) {
    _$recipesAtom.reportWrite(value, super.recipes, () {
      super.recipes = value;
    });
  }

  late final _$recipesAPIAtom =
      Atom(name: '_CookBookStates.recipesAPI', context: context);

  @override
  ObservableFuture<List<Recipe>> get recipesAPI {
    _$recipesAPIAtom.reportRead();
    return super.recipesAPI;
  }

  @override
  set recipesAPI(ObservableFuture<List<Recipe>> value) {
    _$recipesAPIAtom.reportWrite(value, super.recipesAPI, () {
      super.recipesAPI = value;
    });
  }

  late final _$recipesDBAtom =
      Atom(name: '_CookBookStates.recipesDB', context: context);

  @override
  ObservableFuture<List<Recipe>> get recipesDB {
    _$recipesDBAtom.reportRead();
    return super.recipesDB;
  }

  @override
  set recipesDB(ObservableFuture<List<Recipe>> value) {
    _$recipesDBAtom.reportWrite(value, super.recipesDB, () {
      super.recipesDB = value;
    });
  }

  late final _$selectRecipeAtom =
      Atom(name: '_CookBookStates.selectRecipe', context: context);

  @override
  Recipe? get selectRecipe {
    _$selectRecipeAtom.reportRead();
    return super.selectRecipe;
  }

  @override
  set selectRecipe(Recipe? value) {
    _$selectRecipeAtom.reportWrite(value, super.selectRecipe, () {
      super.selectRecipe = value;
    });
  }

  late final _$showSelectRecipeNutrientAtom =
      Atom(name: '_CookBookStates.showSelectRecipeNutrient', context: context);

  @override
  bool get showSelectRecipeNutrient {
    _$showSelectRecipeNutrientAtom.reportRead();
    return super.showSelectRecipeNutrient;
  }

  @override
  set showSelectRecipeNutrient(bool value) {
    _$showSelectRecipeNutrientAtom
        .reportWrite(value, super.showSelectRecipeNutrient, () {
      super.showSelectRecipeNutrient = value;
    });
  }

  late final _$showSelectRecipeIngredientAtom = Atom(
      name: '_CookBookStates.showSelectRecipeIngredient', context: context);

  @override
  bool get showSelectRecipeIngredient {
    _$showSelectRecipeIngredientAtom.reportRead();
    return super.showSelectRecipeIngredient;
  }

  @override
  set showSelectRecipeIngredient(bool value) {
    _$showSelectRecipeIngredientAtom
        .reportWrite(value, super.showSelectRecipeIngredient, () {
      super.showSelectRecipeIngredient = value;
    });
  }

  late final _$filtersAtom =
      Atom(name: '_CookBookStates.filters', context: context);

  @override
  ObservableMap<String, bool> get filters {
    _$filtersAtom.reportRead();
    return super.filters;
  }

  @override
  set filters(ObservableMap<String, bool> value) {
    _$filtersAtom.reportWrite(value, super.filters, () {
      super.filters = value;
    });
  }

  late final _$dietsAtom =
      Atom(name: '_CookBookStates.diets', context: context);

  @override
  ObservableMap<int, CheckBox> get diets {
    _$dietsAtom.reportRead();
    return super.diets;
  }

  @override
  set diets(ObservableMap<int, CheckBox> value) {
    _$dietsAtom.reportWrite(value, super.diets, () {
      super.diets = value;
    });
  }

  late final _$healthAtom =
      Atom(name: '_CookBookStates.health', context: context);

  @override
  ObservableMap<int, CheckBox> get health {
    _$healthAtom.reportRead();
    return super.health;
  }

  @override
  set health(ObservableMap<int, CheckBox> value) {
    _$healthAtom.reportWrite(value, super.health, () {
      super.health = value;
    });
  }

  late final _$cuisineTypeAtom =
      Atom(name: '_CookBookStates.cuisineType', context: context);

  @override
  ObservableMap<int, CheckBox> get cuisineType {
    _$cuisineTypeAtom.reportRead();
    return super.cuisineType;
  }

  @override
  set cuisineType(ObservableMap<int, CheckBox> value) {
    _$cuisineTypeAtom.reportWrite(value, super.cuisineType, () {
      super.cuisineType = value;
    });
  }

  late final _$typeMealAtom =
      Atom(name: '_CookBookStates.typeMeal', context: context);

  @override
  ObservableMap<int, CheckBox> get typeMeal {
    _$typeMealAtom.reportRead();
    return super.typeMeal;
  }

  @override
  set typeMeal(ObservableMap<int, CheckBox> value) {
    _$typeMealAtom.reportWrite(value, super.typeMeal, () {
      super.typeMeal = value;
    });
  }

  late final _$dishTypeAtom =
      Atom(name: '_CookBookStates.dishType', context: context);

  @override
  ObservableMap<int, CheckBox> get dishType {
    _$dishTypeAtom.reportRead();
    return super.dishType;
  }

  @override
  set dishType(ObservableMap<int, CheckBox> value) {
    _$dishTypeAtom.reportWrite(value, super.dishType, () {
      super.dishType = value;
    });
  }

  late final _$dateMealAtom =
      Atom(name: '_CookBookStates.dateMeal', context: context);

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

  late final _$_CookBookStatesActionController =
      ActionController(name: '_CookBookStates', context: context);

  @override
  void changeShowNutrient() {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.changeShowNutrient');
    try {
      return super.changeShowNutrient();
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeShowIngredient() {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.changeShowIngredient');
    try {
      return super.changeShowIngredient();
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fillSelectRecipe(int index) {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.fillSelectRecipe');
    try {
      return super.fillSelectRecipe(index);
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectRecipe() {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.changeSelectRecipe');
    try {
      return super.changeSelectRecipe();
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getRecipeOnAPI() {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.getRecipeOnAPI');
    try {
      return super.getRecipeOnAPI();
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fillByType() {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.fillByType');
    try {
      return super.fillByType();
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTypeRecipe() {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.changeTypeRecipe');
    try {
      return super.changeTypeRecipe();
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFavoriteRecipeIndex(int index) {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.changeFavoriteRecipeIndex');
    try {
      return super.changeFavoriteRecipeIndex(index);
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFavoriteRecipeId(String id) {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.changeFavoriteRecipeId');
    try {
      return super.changeFavoriteRecipeId(id);
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initRecipes(List<Recipe> recipes) {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.initRecipes');
    try {
      return super.initRecipes(recipes);
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCheckButton(
      ObservableMap<int, dynamic> map, int key, bool? check) {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.changeCheckButton');
    try {
      return super.changeCheckButton(map, key, check);
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeVisibilityFilter(int indexFilter) {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.changeVisibilityFilter');
    try {
      return super.changeVisibilityFilter(indexFilter);
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeDateMeal(DateTime calendar) {
    final _$actionInfo = _$_CookBookStatesActionController.startAction(
        name: '_CookBookStates.changeDateMeal');
    try {
      return super.changeDateMeal(calendar);
    } finally {
      _$_CookBookStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favorite: ${favorite},
recipes: ${recipes},
recipesAPI: ${recipesAPI},
recipesDB: ${recipesDB},
selectRecipe: ${selectRecipe},
showSelectRecipeNutrient: ${showSelectRecipeNutrient},
showSelectRecipeIngredient: ${showSelectRecipeIngredient},
filters: ${filters},
diets: ${diets},
health: ${health},
cuisineType: ${cuisineType},
typeMeal: ${typeMeal},
dishType: ${dishType},
dateMeal: ${dateMeal}
    ''';
  }
}
