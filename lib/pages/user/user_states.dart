import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrition_assistant/models/control_point.dart';
import 'package:nutrition_assistant/models/target.dart';
import 'package:nutrition_assistant/models/user.dart';

import '../../database/DBProvider.dart';

part 'user_states.g.dart';

class UserStates = _UserStates with _$UserStates;

abstract class _UserStates with Store{

  @observable
  Target target = getEmptyTarget();

  @action
  void setTarget(Target target){
    this.target = target;
  }

  @action
  void changeTarget(){
    DBProvider.db.getTarget().then((value) {
      target = value;
    });
  }

  @observable
  ControlPoint lastPoint = getEmptyControlPoint();

  @observable
  int userWeight = 0;

  @computed
  double get progress => (lastPoint.weight - userWeight).abs()/(target.targetWeight - userWeight).abs();

  @computed
  int get progressPercentage => (progress.isNaN || progress.isInfinite ? 0 : progress * 100).round();

  @action
  void initUserWeight(int userWeight){
    this.userWeight = userWeight;
  }

  @action
  void getLastPoint(){
    DBProvider.db.getLastControlPoint().then((value) {
      if(value.id == 0){
        lastPoint = ControlPoint(
            id: 1,
            userId: 1,
            targetId: 1,
            weight: userWeight,
            dateTime: DateTime.now());
      }else{
        lastPoint = value;
      }
    });
  }

  @observable
  int indexNewTarget = 0;

  @action
  void changeIndexNewTarget(String value){
    indexNewTarget = targets.indexOf(value);
  }

  @observable
  double currentSliderValue = 5;

  @action
  void changeSliderValue(double value){
    currentSliderValue = value;
  }

  @observable
  bool activeButtonChange = false;

  @action
  void checkActiveButton(String value){
    if(value != "") {
      activeButtonChange = true;
    } else {
      activeButtonChange = false;
    }
  }

  /*
  non observable
   */
  var targets = ["Сброс веса", "Удержание веса", "Набор веса"];

  var newWeightController = TextEditingController();
  var weightController = TextEditingController();
}