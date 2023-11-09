import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrition_assistant/database/DBProvider.dart';
import 'package:nutrition_assistant/models/meal.dart';

part 'calendar_states.g.dart';

class CalendarStates = _CalendarStates with _$CalendarStates;

abstract class _CalendarStates with Store{
  @observable
  ObservableList<Meal> meal = ObservableList.of([]);

  @observable
  var fullEvents = ObservableList<CalendarEvent>.of([]);

  @observable
  var shortEvents = ObservableList<CalendarEvent>.of([]);

  @action
  void initMeal(){
    DBProvider.db.getAllMeal().then((value){
      Map<String, double> totalCalories = {};
      List<CalendarEvent> tempEvent = [];

      for(var element in value){
        String dateStr = element.dateTime.toString().split(" ")[0];
        if(totalCalories.containsKey(dateStr)){
          totalCalories[dateStr] = totalCalories[dateStr]! + element.calories;
        }else{
          totalCalories[dateStr] = element.calories;
        }

        tempEvent.add(CalendarEvent(
            eventName: "${element.name}: ${element.calories}",
            eventDate: element.dateTime,
            eventTextStyle: const TextStyle()
        ));
      }

      fullEvents.removeWhere((element) => true);
      shortEvents.removeWhere((element) => true);

      totalCalories.forEach((date, calories) {
        fullEvents.add(CalendarEvent(
            eventName: "Всего каллорий: $calories",
            eventDate: DateTime.parse(date),
            eventTextStyle: const TextStyle()));

        shortEvents.add(CalendarEvent(
          eventName: calories.toStringAsFixed(1),
          eventDate: DateTime.parse(date),
          eventTextStyle: const TextStyle(fontSize: 14),
          eventBackgroundColor: Colors.transparent,
        ));
      });

      for (var element in tempEvent) {
        fullEvents.add(element);
      }
    });
      
    // Тестовое добавление
    // meal.add(Meal(id: 1, name: "Завтрак", dateTime: DateTime.parse("2023-06-25 00:00:00.000"), calories: 1000));
    // meal.add(Meal(id: 1, name: "Обед", dateTime: DateTime.parse("2023-06-25 00:00:00.000"), calories: 1100));
    // meal.add(Meal(id: 1, name: "Завтрак", dateTime: DateTime.parse("2023-06-22 00:00:00.000"), calories: 1200));
    // meal.add(Meal(id: 1, name: "Обед", dateTime: DateTime.parse("2023-06-23 00:00:00.000"), calories: 1300));
    // meal.add(Meal(id: 1, name: "Полдник", dateTime: DateTime.parse("2023-06-22 00:00:00.000"), calories: 1400));
  }

  @observable
  String year = "";
  String month = "";

  @action
  void setYearMonth(DateTime datetime){
    year = datetime.year.toString();
    month = datetime.month.monthName;
  }

  /*
  NON observable
   */

  final cellCalendarPageController = CellCalendarPageController();

  final labels = ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"];
}