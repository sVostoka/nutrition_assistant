import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/database/DBProvider.dart';
import 'package:nutrition_assistant/models/recipe/ingredient.dart';
import 'package:nutrition_assistant/models/recipe/nutrient.dart';
import 'package:nutrition_assistant/models/recipe/recipe.dart';

import 'cookbook_states.dart';
import 'filter.dart';

final cookbookStates = CookBookStates();

class CookBook extends StatelessWidget {
  const CookBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cookbookStates.getRecipeOnAPI();
    cookbookStates.fillByType();
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Книга рецептов"),
              actions:<Widget>[
              Observer(
                  builder: (_) => IconButton(
                      icon: cookbookStates.favorite ?
                      const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
                      onPressed: (){
                        cookbookStates.changeTypeRecipe();
                        cookbookStates.fillByType();
                      }),
              ),
              IconButton(icon: const Icon(Icons.filter_alt), onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                        Filter(cookbookStates)));

              })
            ]
            ),
            body: Observer(
              builder: (_) => Align(
              alignment: Alignment.center,
              child: FutureBuilder<List<Recipe>>(
                      future: cookbookStates.recipes,
                      builder: (BuildContext context, AsyncSnapshot<List<Recipe>> recipes){
                        if(recipes.hasData){
                          if(recipes.data!.isNotEmpty){
                            var data = recipes.data!;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index){
                                return _recipe(context, data[index], index);
                              },
                            );
                          }else{
                            return const Text("По данным фильтрам рецептов не найдено");
                          }
                        }else{
                          return const Center(child: CircularProgressIndicator());
                        }
                      }
                  )
              )
          ),
        )
    );
  }
}

Widget _recipe(BuildContext context, Recipe recipe, int index){
  return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1), // changes position of shadow
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Image(
                      width: 150,
                      image: NetworkImage(recipe.image)
                  ),
                ),
                const SizedBox(width: 15),
                Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.label,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Прием пищи:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                          ),
                        ),
                        Text(recipe.mealType.first),
                        const SizedBox(height: 5),
                        const Text(
                          "Тип блюда:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(recipe.dishType.first),
                        const SizedBox(height: 5),
                        const Text(
                          "Количество каллорий:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(recipe.calories.toStringAsFixed(2)),
                        const SizedBox(height: 5),
                      ],
                    )
                )
              ],
            ),
          ),
        ),
        onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => _showAlertDialog(context, index)
        ),
      )
  );
}

Widget _showAlertDialog(BuildContext context, int index){
  cookbookStates.fillSelectRecipe(index);
  return Observer(
      builder: (_) => AlertDialog(
        title: Image(
          image: NetworkImage(cookbookStates.selectRecipe!.image)
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      cookbookStates.selectRecipe!.label,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: (){
                        if(cookbookStates.selectRecipe!.favorite){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => _showDeleteAlertDialog(context, cookbookStates.selectRecipe!)
                          );
                        }else{
                          DBProvider.db.newRecipeObj(cookbookStates.selectRecipe!);
                          cookbookStates.changeFavoriteRecipeIndex(index);
                          cookbookStates.changeSelectRecipe();
                        }
                      },
                      icon: cookbookStates.selectRecipe!.favorite ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border)
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Подходит для следующих диет:",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 5),
              Text(cookbookStates.selectRecipe!.dietLabels.join(", ")),
              const SizedBox(height: 15),
              const Text(
                "Подходит для следующих особенностей здоровья:",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 5),
              Text(cookbookStates.selectRecipe!.cautions.join(", ")),
              const SizedBox(height: 15),
              const Text(
                "Тип приема пищи:",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 5),
              Text(cookbookStates.selectRecipe!.mealType.join(", ")),
              const SizedBox(height: 15),
              const Text(
                "Тип блюда:",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 5),
              Text(cookbookStates.selectRecipe!.dishType.join(", ")),
              const SizedBox(height: 15),
              const Text(
                "Национальная кухня:",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 5),
              Text(cookbookStates.selectRecipe!.cuisineType.join(", ")),
              const SizedBox(height: 15),
              const Text(
                "Время приготовления в минутах:",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 5),
              Text(cookbookStates.selectRecipe!.totalTime.toStringAsFixed(2)),
              const SizedBox(height: 15),
              const Text(
                "Общий вес порции:",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 5),
              Text(cookbookStates.selectRecipe!.totalWeight.toStringAsFixed(2)),
              const SizedBox(height: 15),
              const Text(
                "Количество каллорий:",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 5),
              Text(cookbookStates.selectRecipe!.calories.toStringAsFixed(2)),
              const SizedBox(height: 15),
              InkWell(
                  splashColor: Colors.grey,
                  onTap: (){
                    cookbookStates.changeShowIngredient();
                  },
                  child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Text(
                            "Необходимые ингридиенты:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(cookbookStates.showSelectRecipeIngredient ?
                          Icons.expand_less : Icons.expand_more)
                        ],
                      )
                  )
              ),
              const SizedBox(height: 5),
              if(cookbookStates.showSelectRecipeIngredient)
                _showIngredients(cookbookStates.selectRecipe!.ingredients),
              const SizedBox(height: 15),
              InkWell(
                splashColor: Colors.grey,
                onTap: (){
                  cookbookStates.changeShowNutrient();
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Text(
                        "Пищевая ценность:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Icon(cookbookStates.showSelectRecipeNutrient ?
                        Icons.expand_less : Icons.expand_more)
                    ],
                  )
                )
              ),
              const SizedBox(height: 5),
              if(cookbookStates.showSelectRecipeNutrient)
                _showNutrients(cookbookStates.selectRecipe!.totalNutrients),
              const SizedBox(height: 15),
              Flexible(
                  child: ElevatedButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => Observer(
                                builder: (_) => AlertDialog(
                                  title: Text("Добавление приема пищи"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: cookbookStates.textControllerNameMeal,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Название приема пищи'),
                                      ),
                                      const SizedBox(height: 5),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: const Size.fromHeight(55),
                                          ),
                                          onPressed: () async{
                                            DateTime? calendar = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime.now()
                                            );

                                            if(calendar != null){
                                              cookbookStates.changeDateMeal(calendar);
                                            }
                                          },
                                          child: cookbookStates.dateMeal == null
                                              ? const Text("Выберите дату приема пищи")
                                              : Column(
                                            children: [
                                              const Text("Дата приема пищи"),
                                              Text("${cookbookStates.dateMeal!.day}/"
                                                  "${cookbookStates.dateMeal!.month}/"
                                                  "${cookbookStates.dateMeal!.year}")
                                            ],
                                          )
                                      ),
                                      const SizedBox(height: 5),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size.fromHeight(55),
                                        ),
                                        onPressed: () {
                                          DBProvider.db.newMealParams(
                                              cookbookStates.textControllerNameMeal.text == ""
                                                  ? "Прием пищи" : cookbookStates.textControllerNameMeal.text,
                                              cookbookStates.dateMeal ?? DateTime.now(),
                                              cookbookStates.selectRecipe!.calories);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Добавить"),
                                      )
                                    ],
                                  ),
                                )
                            )
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add),
                          const Text("Добавить в прием пищи")
                        ],
                      )
                  ),
              )
            ],
          ),
        ),
      )
  );
}

Widget _showDeleteAlertDialog(BuildContext context, Recipe recipe){
  return AlertDialog(
    title: const Text("Удалить рецепт из избранного?"),
    actions: [
      TextButton(
          onPressed: (){
            DBProvider.db.deleteRecipe(recipe.id);
            cookbookStates.changeFavoriteRecipeId(recipe.id);
            cookbookStates.fillByType();
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text("Да")
      ),
      TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text("Нет")
      )
    ],
  );
}

Widget _showIngredients(List<Ingredient> ingredients){
  List<Widget> listWidget = [];

  for(var ingredient in ingredients){
    listWidget.add(
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Colors.grey
                  ),
                )
            ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    ingredient.food,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    )),
                const SizedBox(height: 5),
                Text(
                    "Количество: ${ingredient.quantity.toString()} "
                        "${ingredient.measure.toString()} / "
                        "${ingredient.weight.toStringAsFixed(2)} г.",
                    style: const TextStyle(
                        fontSize: 14
                    )),
                const SizedBox(height: 5),
                Text(
                    "Описание: ${ingredient.text} ",
                    style: const TextStyle(
                        fontSize: 14
                    )),
              ],
            ),
          )
        )
    );
  }
  listWidget.add(Container(
        decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey
              )
            ))));

  return
    Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listWidget,
    );
}

Widget _showNutrients(List<Nutrient> nutrients){
  List<Widget> listWidget = [];

  for(var nutrient in nutrients){
    listWidget.add(
      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey
            )
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  nutrient.totalLabel,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  )),
              const SizedBox(height: 5),
              Text(
                  "${nutrient.label} ${nutrient.quantity.toStringAsFixed(2)} ${nutrient.unit}",
                  style: const TextStyle(
                      fontSize: 14
                  )),
              const SizedBox(height: 5),
            ],
          ),
        ),
      )
    );
  }
  listWidget.add(Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey
              )
          ))));

  return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listWidget,
    );
}