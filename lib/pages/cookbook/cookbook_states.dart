import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrition_assistant/database/DBProvider.dart';
import 'package:nutrition_assistant/models/performance/checkbox.dart';
import 'package:nutrition_assistant/models/recipe/recipe.dart';
import 'package:nutrition_assistant/network/recipe_api.dart';

part 'cookbook_states.g.dart';

class CookBookStates = _CookBookStates with _$CookBookStates;

abstract class _CookBookStates with Store{

  @observable
  bool favorite = false;

  @observable
  ObservableFuture<List<Recipe>> recipes = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Recipe>> recipesAPI = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Recipe>> recipesDB = ObservableFuture.value([]);

  @observable
  Recipe? selectRecipe;

  @observable
  bool showSelectRecipeNutrient = false;

  @observable
  bool showSelectRecipeIngredient = true;

  @action
  void changeShowNutrient(){
    showSelectRecipeNutrient = !showSelectRecipeNutrient;
  }

  @action
  void changeShowIngredient(){
    showSelectRecipeIngredient = !showSelectRecipeIngredient;
  }

  @action
  void fillSelectRecipe(int index){
    if(favorite){
      selectRecipe = recipesDB.value![index];
    }else{
      selectRecipe = recipesAPI.value![index];
    }
  }

  @action
  void changeSelectRecipe(){
    selectRecipe = Recipe(
        id: selectRecipe!.id,
        favorite: !selectRecipe!.favorite,
        label: selectRecipe!.label,
        image: selectRecipe!.image,
        source: selectRecipe!.source,
        dietLabels: selectRecipe!.dietLabels,
        healthLabels: selectRecipe!.healthLabels,
        cautions: selectRecipe!.cautions,
        ingredientLines: selectRecipe!.ingredientLines,
        ingredients: selectRecipe!.ingredients,
        calories: selectRecipe!.calories,
        totalWeight: selectRecipe!.totalWeight,
        totalTime: selectRecipe!.totalTime,
        cuisineType: selectRecipe!.cuisineType,
        mealType: selectRecipe!.mealType,
        dishType: selectRecipe!.dishType,
        totalNutrients: selectRecipe!.totalNutrients
    );
  }

  @action
  void getRecipeOnAPI(){
    recipesAPI = ObservableFuture(RecipeAPI.getRecipes(
        diets: diets, health: health, cuisineType: cuisineType,
        typeMeal: typeMeal, dishType: dishType));
  }

  @action
  void fillByType(){
    if(favorite){
      recipesDB = ObservableFuture(DBProvider.db.getFilterRecipes(
          diets: diets, health: health, cuisineType: cuisineType,
          typeMeal: typeMeal, dishType: dishType
      ));
      recipes = recipesDB;
    }else{
      recipes = recipesAPI;
    }
  }

  @action
  void changeTypeRecipe(){
    favorite = !favorite;
  }

  @action
  void changeFavoriteRecipeIndex(int index){
    recipes = ObservableFuture(getChangeListIndex(index));
  }

  Future<List<Recipe>> getChangeListIndex(int index) async{
    List<Recipe> list = recipesAPI.value ?? [];

    list[index] = Recipe(
        id: list[index].id,
        favorite: !list[index].favorite,
        label: list[index].label,
        image: list[index].image,
        source: list[index].source,
        dietLabels: list[index].dietLabels,
        healthLabels: list[index].healthLabels,
        cautions: list[index].cautions,
        ingredientLines: list[index].ingredientLines,
        ingredients: list[index].ingredients,
        calories: list[index].calories,
        totalWeight: list[index].totalWeight,
        totalTime: list[index].totalTime,
        cuisineType: list[index].cuisineType,
        mealType: list[index].mealType,
        dishType: list[index].dishType,
        totalNutrients: list[index].totalNutrients);
    return list;
  }

  @action
  void changeFavoriteRecipeId(String id){
    recipes = ObservableFuture(getChangeListId(id));
  }

  Future<List<Recipe>> getChangeListId(String id) async{
    List<Recipe> list = recipesAPI.value ?? [];

    list.asMap().forEach((index, recipe) {
      if(recipe.id == id) {
        list[index] = Recipe(
            id: list[index].id,
            favorite: !list[index].favorite,
            label: list[index].label,
            image: list[index].image,
            source: list[index].source,
            dietLabels: list[index].dietLabels,
            healthLabels: list[index].healthLabels,
            cautions: list[index].cautions,
            ingredientLines: list[index].ingredientLines,
            ingredients: list[index].ingredients,
            calories: list[index].calories,
            totalWeight: list[index].totalWeight,
            totalTime: list[index].totalTime,
            cuisineType: list[index].cuisineType,
            mealType: list[index].mealType,
            dishType: list[index].dishType,
            totalNutrients: list[index].totalNutrients);
      }
    });

    return list;
  }

  @observable
  var filters = ObservableMap<String, bool>.of({
    "Диета": false,
    "Здоровье": false,
    "Тип кухни": false,
    "Прием пищи": false,
    "Тип блюда": false
  });

  @observable
  var diets = ObservableMap<int, CheckBox>.of({
    0: CheckBox(
        check: true,
        techName: "Balanced",
        apiParameter: "balanced",
        name: "Сбалансированная",
        description: "Белки/жиры/углеводы в соотношении 15/35/50"),
    1: CheckBox(
        check: false,
        techName: "High-Fiber",
        apiParameter: "high-fiber",
        name: "Высокое содержание клетчатки",
        description: "Более 5 г клетчатки на порцию"),
    2: CheckBox(
        check: false,
        techName: "High-Protein",
        apiParameter: "high-protein",
        name: "Высокое содержание белка",
        description: "Белки составляют более 50% от общего количества калорий"),
    3: CheckBox(
        check: false,
        techName: "Low-Carb",
        apiParameter: "low-carb",
        name: "Низкое содержание углеводов",
        description: "Менее 20% от общего количества калорий приходится на углеводы"),
    4: CheckBox(
        check: false,
        techName: "Low-Fat",
        apiParameter: "low-fat",
        name: "Низкое содержание жира",
        description: "Менее 15% от общего количества калорий приходится на жир"),
    5: CheckBox(
        check: false,
        techName: "Low-Sodium",
        apiParameter: "low-sodium",
        name: "Низкое содержание натрия",
        description: "Менее 140 мг натрия на порцию")
  });

  @observable
  var health = ObservableMap<int, CheckBox>.of({
    0: CheckBox(
        check: false,
        techName: "Alcohol-Cocktail",
        apiParameter: "alcohol-cocktail",
        name: "Содержащие алкоголь",
        description: "С содержанием алкоголя"),
    1: CheckBox(
        check: false,
        techName: "Alcohol-Free",
        apiParameter: "alcohol-free",
        name: "Безалкогольное",
        description: "Без использования алкоголя"),
    2: CheckBox(
        check: false,
        techName: "Celery-Free",
        apiParameter: "celery-free",
        name: "Без использования сельдерея",
        description: "Без содержания сельдерея или производных"),
    3: CheckBox(
        check: false,
        techName: "Crustcean-Free",
        apiParameter: "crustacean-free",
        name: "Без ракообразных",
        description: "Без содержания ракообразных (креветок, омаров и т. д.) или производных"),
    4: CheckBox(
        check: false,
        techName: "Dairy-Free",
        apiParameter: "dairy-free",
        name: "Без молока",
        description: "Без использования молочных продуктов, без лактозы"),
    5: CheckBox(
        check: false,
        techName: "DASH",
        apiParameter: "DASH",
        name: "Для больных гипертонией",
        description: "Диетические подходы к остановке гипертонии"),
    6: CheckBox(
        check: false,
        techName: "Egg-Free",
        apiParameter: "egg-free",
        name: "Без яиц",
        description: "Без использования яиц или продуктов, содержащих яйца"),
    7: CheckBox(
        check: false,
        techName: "Fish-Free",
        apiParameter: "fish-free",
        name: "Без рыбы",
        description: "Без рыбы и рыбных производных"),
    8: CheckBox(
        check: false,
        techName: "FODMAP-Free",
        apiParameter: "fodmap-free",
        name: "Без ферментируемых Олиго-Ди-Моно-Полисахаридов",
        description: "Не содержит продуктов ферментируемых Олиго-Ди-Моно-Полисахаридов"),
    9: CheckBox(
        check: false,
        techName: "Gluten-Free",
        apiParameter: "gluten-free",
        name: "Не содержит глютен",
        description: "Нет ингредиентов, содержащих глютен"),
    10: CheckBox(
        check: false,
        techName: "Immuno-Supportive",
        apiParameter: "immuno-supportive",
        name: "Иммуноподдерживающий",
        description: "Рецепты, соответствующие научно обоснованному подходу к питанию для укрепления иммунной системы"),
    11: CheckBox(
        check: false,
        techName: "Кетогенная диета",
        apiParameter: "keto-friendly",
        name: "Низкое содержание натрия",
        description: "Максимум 7 граммов чистых углеводов на порцию"),
    12: CheckBox(
        check: false,
        techName: "Kidney-Friendly",
        apiParameter: "kidney-friendly",
        name: "Дружественный к почкам",
        description: "На порцию – фосфора менее 250 мг И калия менее 500 мг И натрия менее 500 мг"),
    13: CheckBox(
        check: false,
        techName: "Kosher",
        apiParameter: "kosher",
        name: "Кошерный",
        description: "Содержит только ингредиенты, разрешенные кошерной диетой. "
            "Однако это не гарантирует кошерного приготовления самих ингредиентов."),
    14: CheckBox(
        check: false,
        techName: "Low Potassium",
        apiParameter: "low-potassium",
        name: "Низкий калий",
        description: "Менее 150 мг на порцию"),
    15: CheckBox(
        check: false,
        techName: "Low Sugar",
        apiParameter: "low-sugar",
        name: "Низкий уровень сахара",
        description: "Без простых сахаров — глюкозы, декстрозы, галактозы, фруктозы, сахарозы, лактозы, мальтозы"),
    16: CheckBox(
        check: false,
        techName: "Lupine-Free",
        apiParameter: "lupine-free",
        name: "Без люпина",
        description: "Не содержит люпина и его производных"),
    17: CheckBox(
        check: false,
        techName: "Mediterranean",
        apiParameter: "Mediterranean",
        name: "Средиземное море",
        description: "Средиземноморская диета"),
    18: CheckBox(
        check: false,
        techName: "Mollusk-Free",
        apiParameter: "mollusk-free",
        name: "Без моллюсков",
        description: "Нет моллюсков"),
    19: CheckBox(
        check: false,
        techName: "Mustard-Free",
        apiParameter: "mustard-free",
        name: "Без горчицы",
        description: "Не содержит горчицы или производных"),
    20: CheckBox(
        check: false,
        techName: "No oil added",
        apiParameter: "No-oil-added",
        name: "Без добавления масла",
        description: "Масло не добавляется, кроме того, что содержится в основных ингредиентах"),
    21: CheckBox(
        check: false,
        techName: "Paleo",
        apiParameter: "paleo",
        name: "Палео",
        description: "Исключает то, что считается сельскохозяйственной продукцией; "
            "зерновые, бобовые, молочные продукты, картофель, рафинированная соль, "
            "рафинированный сахар и переработанные масла"),
    22: CheckBox(
        check: false,
        techName: "Peanut-Free",
        apiParameter: "peanut-free",
        name: "Без арахиса",
        description: "Без арахиса и продуктов, содержащих арахис"),
    23: CheckBox(
        check: false,
        techName: "Pescatarian",
        apiParameter: "pecatarian",
        name: "Пескетарианец",
        description: "Не содержит мяса или мясных продуктов, может содержать молочные продукты и рыбу"),
    24: CheckBox(
        check: false,
        techName: "Pork-Free",
        apiParameter: "pork-free",
        name: "Без свинины",
        description: "Не содержит свинины или производных"),
    25: CheckBox(
        check: false,
        techName: "Red-Meat-Free",
        apiParameter: "red-meat-free",
        name: "Без красного мяса",
        description: "Не содержит говядины, баранины, свинины, утки, гуся, дичи, "
            "лошади и других видов красного мяса или продуктов, содержащих красное мясо"),
    26: CheckBox(
        check: false,
        techName: "Sesame-Free",
        apiParameter: "sesame-free",
        name: "Без кунжута",
        description: "Не содержит семян кунжута или производных"),
    27: CheckBox(
        check: false,
        techName: "Shellfish-Free",
        apiParameter: "shellfish-free",
        name: "Без раков",
        description: "Нет раков или производных раков"),
    28: CheckBox(
        check: false,
        techName: "Soy-Free",
        apiParameter: "soy-free",
        name: "Без сои",
        description: "	Нет сои или продуктов, содержащих сою"),
    29: CheckBox(
        check: false,
        techName: "Sugar-Conscious",
        apiParameter: "sugar-conscious",
        name: "Ограничение сахара",
        description: "Менее 4 г сахара на порцию"),
    30: CheckBox(
        check: false,
        techName: "Sulfite-Free",
        apiParameter: "sulfite-free",
        name: "Без сульфитов",
        description: "Нет сульфитов"),
    31: CheckBox(
        check: false,
        techName: "Tree-Nut-Free",
        apiParameter: "tree-nut-free",
        name: "Без орехов",
        description: "Никаких лесных орехов или продуктов, содержащих лесные орехи"),
    32: CheckBox(
        check: false,
        techName: "Vegan",
        apiParameter: "vegan",
        name: "Веган",
        description: "Без мяса, птицы, рыбы, молочных продуктов, яиц или меда"),
    33: CheckBox(
        check: false,
        techName: "Vegetarian",
        apiParameter: "vegetarian",
        name: "Вегетарианец",
        description: "Нет мяса, птицы или рыбы"),
    34: CheckBox(
        check: false,
        techName: "Wheat-Free",
        apiParameter: "wheat-free",
        name: "Без пшеницы",
        description: "Нет пшеницы, но может быть глютен")
  });

  @observable
  var cuisineType = ObservableMap<int, CheckBox>.of({
    0: CheckBox(
        check: false,
        techName: "american",
        apiParameter: "american",
        name: "Американская",
        description: ""),
    1: CheckBox(
        check: false,
        techName: "asian",
        apiParameter: "asian",
        name: "Азиатская",
        description: ""),
    2: CheckBox(
        check: false,
        techName: "british",
        apiParameter: "british",
        name: "Британская",
        description: ""),
    3: CheckBox(
        check: false,
        techName: "caribbean",
        apiParameter: "caribbean",
        name: "Карибская",
        description: ""),
    4: CheckBox(
        check: false,
        techName: "central europe",
        apiParameter: "central europe",
        name: "Центральноевропейская",
        description: ""),
    5: CheckBox(
        check: false,
        techName: "chinese",
        apiParameter: "chinese",
        name: "Китайская",
        description: ""),
    6: CheckBox(
        check: false,
        techName: "eastern europe",
        apiParameter: "eastern europe",
        name: "Восточноевропейская",
        description: ""),
    7: CheckBox(
        check: false,
        techName: "french",
        apiParameter: "french",
        name: "Французская",
        description: ""),
    8: CheckBox(
        check: false,
        techName: "greek",
        apiParameter: "greek",
        name: "Греческая",
        description: ""),
    9: CheckBox(
        check: false,
        techName: "indian",
        apiParameter: "indian",
        name: "Индийская",
        description: ""),
    10: CheckBox(
        check: false,
        techName: "italian",
        apiParameter: "italian",
        name: "Итальянская",
        description: ""),
    11: CheckBox(
        check: false,
        techName: "japanese",
        apiParameter: "japanese",
        name: "Японская",
        description: ""),
    12: CheckBox(
        check: false,
        techName: "korean",
        apiParameter: "korean",
        name: "Корейская",
        description: ""),
    13: CheckBox(
        check: false,
        techName: "kosher",
        apiParameter: "kosher",
        name: "Кошерная",
        description: ""),
    14: CheckBox(
        check: false,
        techName: "mediterranean",
        apiParameter: "mediterranean",
        name: "Средиземноморская",
        description: ""),
    15: CheckBox(
        check: false,
        techName: "mexican",
        apiParameter: "mexican",
        name: "Мексиканская",
        description: ""),
    16: CheckBox(
        check: false,
        techName: "middle eastern",
        apiParameter: "middle eastern",
        name: "Ближневосточная",
        description: ""),
    17: CheckBox(
        check: false,
        techName: "nordic",
        apiParameter: "nordic",
        name: "Скандинавская",
        description: ""),
    18: CheckBox(
        check: false,
        techName: "south american",
        apiParameter: "south american",
        name: "Южноамериканская",
        description: ""),
    19: CheckBox(
        check: false,
        techName: "south east asian",
        apiParameter: "south east asian",
        name: "Юго-Восточноазиатская",
        description: ""),
    20: CheckBox(
        check: false,
        techName: "world",
        apiParameter: "world",
        name: "Мировая",
        description: ""
    )
  });

  @observable
  var typeMeal = ObservableMap<int, CheckBox>.of({
    0: CheckBox(
        check: false,
        techName: "breakfast",
        apiParameter: "breakfast",
        name: "Завтрак",
        description: ""),
    1: CheckBox(
        check: false,
        techName: "brunch",
        apiParameter: "brunch",
        name: "Поздний завтрак",
        description: ""),
    2: CheckBox(
        check: false,
        techName: "lunch/dinner",
        apiParameter: "lunch/dinner",
        name: "Обед",
        description: ""),
    3: CheckBox(
        check: false,
        techName: "snack",
        apiParameter: "snack",
        name: "Закуска",
        description: ""),
    4: CheckBox(
        check: false,
        techName: "teatime",
        apiParameter: "teatime",
        name: "Время чая",
        description: ""),
  });

  @observable
  var dishType = ObservableMap<int, CheckBox>.of({
    0: CheckBox(
        check: false,
        techName: "alcohol cocktail",
        apiParameter: "alcohol cocktail",
        name: "Алкогольный коктейль",
        description: ""),
    1: CheckBox(
        check: false,
        techName: "biscuits and cookies",
        apiParameter: "biscuits and cookies",
        name: "Галеты и печенья",
        description: ""),
    2: CheckBox(
        check: false,
        techName: "bread",
        apiParameter: "bread",
        name: "Хлеб",
        description: ""),
    3: CheckBox(
        check: false,
        techName: "cereals",
        apiParameter: "cereals",
        name: "Хлопья",
        description: ""),
    4: CheckBox(
        check: false,
        techName: "condiments and sauces",
        apiParameter: "condiments and sauces",
        name: "Приправы и соусы",
        description: ""),
    5: CheckBox(
        check: false,
        techName: "desserts",
        apiParameter: "desserts",
        name: "Десерты",
        description: ""),
    6: CheckBox(
        check: false,
        techName: "drinks",
        apiParameter: "drinks",
        name: "Напитки",
        description: ""),
    7: CheckBox(
        check: false,
        techName: "egg",
        apiParameter: "egg",
        name: "Яйцо",
        description: ""),
    8: CheckBox(
        check: false,
        techName: "ice cream and custard",
        apiParameter: "ice cream and custard",
        name: "Мороженое и заварной крем",
        description: ""),
    9: CheckBox(
        check: false,
        techName: "main course",
        apiParameter: "main course",
        name: "Основное блюдо",
        description: ""),
    10: CheckBox(
        check: false,
        techName: "pancake",
        apiParameter: "pancake",
        name: "Блины",
        description: ""),
    11: CheckBox(
        check: false,
        techName: "pasta",
        apiParameter: "pasta",
        name: "Макаронные изделия",
        description: ""),
    12: CheckBox(
        check: false,
        techName: "pastry",
        apiParameter: "pastry",
        name: "Выпечка",
        description: ""),
    13: CheckBox(
        check: false,
        techName: "pies and tarts",
        apiParameter: "pies and tarts",
        name: "Пироги и торты",
        description: ""),
    14: CheckBox(
        check: false,
        techName: "pizza",
        apiParameter: "pizza",
        name: "Пицца",
        description: ""),
    15: CheckBox(
        check: false,
        techName: "preps",
        apiParameter: "preps",
        name: "Суточный рацион",
        description: ""),
    16: CheckBox(
        check: false,
        techName: "preserve",
        apiParameter: "preserve",
        name: "Варенье",
        description: ""),
    17: CheckBox(
        check: false,
        techName: "salad",
        apiParameter: "salad",
        name: "Салат",
        description: ""),
    18: CheckBox(
        check: false,
        techName: "sandwiches",
        apiParameter: "sandwiches",
        name: "Сендвичи",
        description: ""),
    19: CheckBox(
        check: false,
        techName: "seafood",
        apiParameter: "seafood",
        name: "Морепродукты",
        description: ""),
    20: CheckBox(
        check: false,
        techName: "side dish",
        apiParameter: "side dish",
        name: "Гарнир",
        description: ""),
    21: CheckBox(
        check: false,
        techName: "soup",
        apiParameter: "soup",
        name: "Суп",
        description: ""),
    22: CheckBox(
        check: false,
        techName: "special occasions",
        apiParameter: "special occasions",
        name: "Особые",
        description: ""),
    23: CheckBox(
        check: false,
        techName: "starter",
        apiParameter: "starter",
        name: "Закуски",
        description: ""),
    24: CheckBox(
        check: false,
        techName: "sweets",
        apiParameter: "sweets",
        name: "Сладости",
        description: ""),
  });

  @action
  void initRecipes(List<Recipe> recipes){
    for (var recipe in recipes) {
      recipes.add(recipe);
    }
  }
  
  @action
  void changeCheckButton(ObservableMap<int, dynamic> map, int key, bool? check){
    map[key] = CheckBox(
        check: check!,
        techName: map[key]!.techName,
        apiParameter: map[key]!.apiParameter,
        name: map[key]!.name,
        description: map[key]!.description
    );
  }

  @action
  void changeVisibilityFilter(int indexFilter){
    filters[filters.keys.elementAt(indexFilter)] =
    !filters[filters.keys.elementAt(indexFilter)]!;
  }

  @observable
  DateTime? dateMeal;

  @action
  void changeDateMeal(DateTime calendar){
    dateMeal = calendar;
  }

  var textControllerNameMeal = TextEditingController();
}