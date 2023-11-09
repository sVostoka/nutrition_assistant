import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrition_assistant/pages/cookbook/cookbook.dart';
import 'package:nutrition_assistant/pages/cookbook/cookbook_states.dart';

class Filter extends StatelessWidget{
  const Filter(CookBookStates cookbookStates, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Фильтр для поиска рецептов"),
            leading: IconButton(
              onPressed: () {
                cookbookStates.getRecipeOnAPI();
                cookbookStates.fillByType();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: Observer(
            builder: (_) => SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _filterLabel(indexFilter: 0),
                      const SizedBox(height: 5),
                      multipleCheckbox(
                          indexFilter: 0,
                          map: cookbookStates.diets
                      ),
                      const SizedBox(height: 5),
                      _filterLabel(indexFilter: 1),
                      const SizedBox(height: 5),
                      multipleCheckbox(
                          indexFilter: 1,
                          map: cookbookStates.health
                      ),
                      const SizedBox(height: 5),
                      _filterLabel(indexFilter: 2),
                      const SizedBox(height: 5),
                      multipleCheckbox(
                          indexFilter: 2,
                          map: cookbookStates.cuisineType
                      ),
                      const SizedBox(height: 5),
                      _filterLabel(indexFilter: 3),
                      const SizedBox(height: 5),
                      multipleCheckbox(
                          indexFilter: 3,
                          map: cookbookStates.typeMeal
                      ),
                      _filterLabel(indexFilter: 4),
                      const SizedBox(height: 5),
                      multipleCheckbox(
                          indexFilter: 4,
                          map: cookbookStates.dishType
                      ),
                    ],
                  ),
                ),
              ),
            )
          )
        )
    );
  }
}

Widget multipleCheckbox({required int indexFilter,
  required ObservableMap<int, dynamic> map}){
  var list = ObservableList<Widget>.of([]);

  map.forEach((key, item) {
    list.add(
        Visibility(
          visible: cookbookStates.filters[cookbookStates.filters.keys.elementAt(indexFilter)]!,
          child: CheckboxListTile(
              title: Text(item.name),
              subtitle: item.description == "" ? null : Text(item.description),
              contentPadding: const EdgeInsets.symmetric(vertical: 3),
              value: item.check,
              onChanged: (bool? check) {
                cookbookStates.changeCheckButton(map, key, check);
              }),
        )
    );
  });

  return Column(children: list);
}

Widget _filterLabel({required int indexFilter}){
  return InkWell(
    child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cookbookStates.filters.keys.elementAt(indexFilter),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(cookbookStates.filters[cookbookStates.filters.keys.elementAt(indexFilter)]!
                               ? Icons.expand_less : Icons.expand_more)
              ],
            )
    ),
    onTap: (){
      cookbookStates.changeVisibilityFilter(indexFilter);
    },
  );
}

