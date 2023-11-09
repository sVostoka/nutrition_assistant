import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/core/const.dart';
import 'package:nutrition_assistant/database/DBProvider.dart';
import 'package:nutrition_assistant/models/food/food.dart';
import 'package:nutrition_assistant/models/food/measure.dart';
import 'package:nutrition_assistant/models/food/nutrients.dart';
import 'package:nutrition_assistant/pages/add_meal/add_meal.dart';
import 'package:nutrition_assistant/pages/add_meal/add_meal_states.dart';

Widget food(BuildContext context, AddMealStates addMealStates, Food food, int index){
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
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: Image(
                      width: 150,
                      image: NetworkImage(food.image == "" ? emptyFoodImage : food.image)
                  ),
                ),
                const SizedBox(width: 15),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.label,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),),
                      const SizedBox(height: 5),
                      Text("Категория: ${food.category}"),
                      Text("В ${food.measures.first.weight.toStringAsFixed(2)} г."),
                      Text("${food.nutrients.enercKCal.toStringAsFixed(2)} каллорий")
                    ],
                  ),
                )
              ],
            )
        ),
      ),
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) => _showAlertDialog(context, addMealStates, index)
      ),
    ),
  );
}

Widget _showAlertDialog(BuildContext context, AddMealStates addMealStates, int index){
  addMealStates.fillSelectFood(index);
  return Observer(
      builder: (_) => AlertDialog(
        title: Image(
          image: NetworkImage(addMealStates.selectFood!.image == ""
              ? emptyFoodImage : addMealStates.selectFood!.image),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if(addMealStates.typePage != TypePage.addMeal)
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                "Выберите меру и количество",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Flexible(
                                          child: Observer(
                                            builder: (_) => DropdownButton(
                                              value: addMealStates.measureLabel
                                                  ?? addMealStates.selectFood!.measures.first.label,
                                              items: addMealStates.selectFood!.measures.map((Measure value) {
                                                return DropdownMenuItem<String>(
                                                  value: value.label,
                                                  child: Text(value.label),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                addMealStates.changeMeasureLabel(value!);
                                              },
                                            ),
                                          )
                                      ),
                                      Flexible(
                                          child: TextField(
                                              keyboardType: TextInputType.number,
                                              controller: addMealStates.textControllerCountFood,
                                            ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                      onPressed: (){
                                        addMealStates.addFoodTotal();
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add),
                                          Text("Добавить в прием пищи")
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            )
                        );
                      },
                      icon: const Icon(Icons.add),
                    ),
                  IconButton(
                    onPressed: () {
                      if(addMealStates.selectFood!.favorite){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => _showDeleteAlertDialog(context, addMealStates.selectFood!)
                        );
                      }else{
                        DBProvider.db.newFoodObj(addMealStates.selectFood!);
                        addMealStates.changeFavoriteFoodIndex(index);
                        addMealStates.changeSelectFood();
                      }
                    },
                    icon: addMealStates.selectFood!.favorite ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border),
                  ),
                  if(addMealStates.typePage == TypePage.addMeal)
                    IconButton(
                      onPressed: () {
                        addMealStates.delFoodTotal();
                        addMealStates.fillByType();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                addMealStates.selectFood!.label,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Категория:",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 5),
              Text(addMealStates.selectFood!.category),
              const SizedBox(height: 15),
              if(addMealStates.typePage != TypePage.addMeal)...[
                InkWell(
                  splashColor: Colors.grey,
                  onTap: (){
                    addMealStates.changeShowNutrients();
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text(
                          "В ${addMealStates.selectFood!.measures.first.weight.toStringAsFixed(2)} граммах продукта.:",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Icon(addMealStates.showSelectFoodNutrients ?
                        Icons.expand_less : Icons.expand_more)
                      ],
                    ),
                  ),
                ),
              ]else...[
                const Text(
                  "Добавлено в прием пищи:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text("${addMealStates.selectFood!.count} "
                    "${addMealStates.selectFood!.measureCount!.label}"),
              ],
              const SizedBox(height: 5),
              if(addMealStates.showSelectFoodNutrients)
                _showNutrients(addMealStates.selectFood!.nutrients),
            ],
          ),
        ),
      )
  );
}

Widget _showNutrients(Nutrients nutrients){
  List<Widget> listWidget = [];

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Калорий: ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  )),
              const SizedBox(height: 5),
              Text(
                  nutrients.enercKCal.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 14
                  )),
              const SizedBox(height: 5),
            ],
          ),
        ),
      )
  );
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Белок: ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  )),
              const SizedBox(height: 5),
              Text(
                  nutrients.procnt.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 14
                  )),
              const SizedBox(height: 5),
            ],
          ),
        ),
      )
  );
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Жиры: ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  )),
              const SizedBox(height: 5),
              Text(
                  nutrients.fat.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 14
                  )),
              const SizedBox(height: 5),
            ],
          ),
        ),
      )
  );
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Углеводы: ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  )),
              const SizedBox(height: 5),
              Text(
                  nutrients.chocdf.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 14
                  )),
              const SizedBox(height: 5),
            ],
          ),
        ),
      )
  );
  listWidget.add(
      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Colors.grey
                ),
                bottom: BorderSide(
                    color: Colors.grey
                )
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Клетчатка: ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  )),
              const SizedBox(height: 5),
              Text(
                  nutrients.fibig.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 14
                  )),
              const SizedBox(height: 5),
            ],
          ),
        ),
      )
  );

  return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listWidget,
    );
}

Widget _showDeleteAlertDialog(BuildContext context, Food food){
  return AlertDialog(
    title: const Text("Удалить рецепт из избранного?"),
    actions: [
      TextButton(
          onPressed: (){
            DBProvider.db.deleteFood(food.id);
            addMealStates.changeFavoriteFoodId(food.id);
            addMealStates.fillByType();
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