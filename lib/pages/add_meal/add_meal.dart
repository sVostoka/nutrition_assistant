import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/database/DBProvider.dart';
import 'package:nutrition_assistant/models/food/food.dart';
import 'package:nutrition_assistant/network/nutrition_analysis_api.dart';
import 'package:nutrition_assistant/pages/add_meal/add_meal_states.dart';
import 'package:nutrition_assistant/pages/add_meal/add_food.dart';
import 'package:nutrition_assistant/widgets/single_food.dart';


final addMealStates = AddMealStates();

class AddMeal extends StatelessWidget {
  const AddMeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addMealStates.keyboardVisibilityController.onChange.listen((bool visible) {
      addMealStates.hideKeyBoard(visible);
    });
    return SafeArea(child: Scaffold(
        appBar: AppBar(
            title: const Text("Прием пищи"),
            actions:[
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: (){
                    addMealStates.cleanFoodTotal();
                    addMealStates.fillByType();
                  }),
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: (){
                    addMealStates.changeOnAddFood();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                            AddFood(addMealStates)));
              })
            ]
        ),
        body: Observer(
          builder: (_) => Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Observer(
                          builder: (_) => TextField(
                            focusNode: addMealStates.focusNameMeal,
                            controller: addMealStates.textControllerNameMeal,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Название приема пищи'),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Observer(
                          builder: (_) => ElevatedButton(
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
                                  addMealStates.changeDateMeal(calendar);
                                }
                              },
                              child: addMealStates.dateMeal == null
                                  ? const Text("Выберите дату приема пищи")
                                  : Column(
                                      children: [
                                        const Text("Дата приема пищи"),
                                        Text("${addMealStates.dateMeal!.day}/"
                                            "${addMealStates.dateMeal!.month}/"
                                            "${addMealStates.dateMeal!.year}")
                                      ],
                                    )
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Список продуктов",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    FutureBuilder<List<Food>>(
                        future: addMealStates.foods,
                        builder: (BuildContext context, AsyncSnapshot<List<Food>> foods){
                          if(foods.hasData){
                            if(foods.data!.isNotEmpty){
                              var data = foods.data!;
                              return Expanded(
                                  child: ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index){
                                      return food(context, addMealStates, data[index], index);
                                    },
                                  )
                              );
                            }else{
                              return const Text("Ничего не добавлено в прием пищи");
                            }
                          }else{
                            return const Center(child: CircularProgressIndicator());
                          }
                        }
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(55),
                        ),
                        onPressed: (){
                          if(addMealStates.foodsTotal.value!.isNotEmpty){
                            NutrientsAPI.getCalories(addMealStates.foodsTotal.value!).then((value) {
                              DBProvider.db.newMealParams(
                                  addMealStates.textControllerNameMeal.text == ""
                                      ? "Прием пищи" : addMealStates.textControllerNameMeal.text,
                                  addMealStates.dateMeal ?? DateTime.now(),
                                  value
                              );
                              addMealStates.cleanFoodTotal();
                              addMealStates.fillByType();
                            });
                          }
                        },
                        child: const Text("Добавить прием пищи")
                    ),
                  ],
                )
            ),
          ),
        )
    ));
  }
}
