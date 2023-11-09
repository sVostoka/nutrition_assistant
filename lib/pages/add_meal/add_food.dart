import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/models/food/food.dart';
import 'package:nutrition_assistant/pages/add_meal/add_meal.dart';
import 'package:nutrition_assistant/pages/add_meal/add_meal_states.dart';
import 'package:nutrition_assistant/widgets/single_food.dart';

class AddFood extends StatelessWidget {
  const AddFood(AddMealStates addMealStates, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addMealStates.fillByType();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавление продуктов"),
        leading: IconButton(
          onPressed: () {
            addMealStates.changeOnAddMeal();
            addMealStates.fillByType();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          Observer(
            builder: (_) => IconButton(
                icon: addMealStates.typePage == TypePage.favorite ?
                  const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
                onPressed: (){
                  addMealStates.changeFavorite();
                  addMealStates.fillByType();
                }),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Observer(
          builder: (_) => Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Column(
                  children: [
                    Visibility(
                        visible: addMealStates.typePage != TypePage.favorite,
                        child: Column(
                          children: [
                            TextField(
                              focusNode: addMealStates.focusNameFood,
                              controller: addMealStates.textControllerNameFood,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Введите название продукта'),
                            ),
                            const SizedBox(height: 5),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(55),
                                ),
                                onPressed: (){
                                  if(addMealStates.textControllerNameFood.text != ""){
                                    addMealStates.getFoodsOnAPI();
                                    addMealStates.fillByType();
                                  }
                                },
                                child: const Text("Поиск")
                            ),
                            const SizedBox(height: 15),
                          ],
                        )
                    ),
                    Text(
                      addMealStates.typePage != TypePage.favorite
                          ? "Список найденых продуктов" : "Список избранных продуктов",
                      style: const TextStyle(
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
                          return Text(
                            addMealStates.typePage != TypePage.favorite
                              ? "По данному запросу ничего не найдено"
                              : "Список избранного пуст",);
                        }
                      }else{
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                ),
              ],
            ),
          )
        )
      )
    );
  }
}