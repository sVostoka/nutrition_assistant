import 'package:fl_chart/fl_chart.dart';

import 'package:mobx/mobx.dart';
import 'package:nutrition_assistant/database/DBProvider.dart';
import 'package:nutrition_assistant/models/control_point.dart';
import 'package:nutrition_assistant/models/target.dart';

part 'progress_states.g.dart';

class ProgressState = _ProgressState with _$ProgressState;


abstract class _ProgressState with Store {
  @observable
  MyCalendar calendarView = MyCalendar.week;

  @action
  void changeCalendarView(Set<MyCalendar> newSelection) {
    calendarView = newSelection.first;
  }

  @observable
  int? progress;

  @observable
  Target targetUser = getEmptyTarget();

  @action
  void getTargetUser(){
    DBProvider.db.getTarget().then((value) => targetUser = value);
  }

  @observable
  ObservableList<FlSpot> flSpots = ObservableList.of([]);

  @observable
  ObservableList<ControlPoint> controlPoints = ObservableList.of([]);

  @action
  void initControlPoint(){
    DBProvider.db.getControlPoints().then((points) {
      controlPoints.removeWhere((element) => true);
      if(points.isNotEmpty){
        for(var point in points){
          controlPoints.add(point);
        }

        controlPoints.sort((a, b) => a.dateTime.isAfter(b.dateTime) ? -1 : 1);

        if(controlPoints.length < 2){
          progress = 0;
        }else{
          progress = controlPoints[0].weight - controlPoints[1].weight;
        }

        fillByType();
      }
    });
  }

  @action
  void fillByType(){
    DateTime firstDayOfWeek = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - DateTime.now().weekday + 1);
    DateTime firstDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime firstDayOfYear = DateTime(DateTime.now().year, DateTime.january, 1);

    flSpots.removeWhere((element) => true);

    if (calendarView == MyCalendar.week) {
      for (var point in controlPoints) {
        if (point.dateTime.isBefore(DateTime.now()) &&
            point.dateTime.isAfter(firstDayOfWeek)) {
          flSpots.add(
              FlSpot(point.dateTime.weekday.toDouble(), point.weight.toDouble()));
        }
      }
    }
    if (calendarView == MyCalendar.month) {
      for (var point in controlPoints) {
        if (point.dateTime.isBefore(DateTime.now()) &&
            point.dateTime.isAfter(firstDayOfMonth)) {
          flSpots.add(FlSpot(point.dateTime.day.toDouble(), point.weight.toDouble()));
        }
      }
    }
    if (calendarView == MyCalendar.year) {
      for (var point in controlPoints) {
        if (point.dateTime.isBefore(DateTime.now()) &&
            point.dateTime.isAfter(firstDayOfYear)) {
          flSpots.add(FlSpot(point.dateTime.month.toDouble(), point.weight.toDouble()));
        }
      }
    }

    flSpots.sort((a, b) => a.x.compareTo(b.x));
  }

  // @action
  // getLastPointWeight() {
  //   return controlPointsList.last.weight.toInt().toString();
  // }
  //
  // @action
  // getPointDiff() {
  //   return (controlPointsList.last.weight - controlPointsList[controlPointsList.toList().length-2].weight.toDouble()).toString();
  // }
}

enum MyCalendar {week, month, year}
