import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrition_assistant/database/DBProvider.dart';
import 'package:nutrition_assistant/models/target.dart';
import 'package:nutrition_assistant/models/user.dart';

part 'auth_states.g.dart';

class AuthState = _AuthState with _$AuthState;

abstract class _AuthState with Store{

  /*
  init user element
   */
  late User user;

  @observable
  String username = "";

  @observable
  Gender gender = Gender.man;

  @observable
  int weight = 0;

  @observable
  int height = 0;

  @observable
  DateTime dateOfBirth = DateTime.now();

  @action
  void setUserName(String username){
    this.username = username;
  }

  @action
  void setGender(Gender gender){
    this.gender = gender;
  }

  @action
  void setWeight(int weight){
    this.weight = weight;
  }

  @action
  void setHeight(int height){
    this.height = height;
  }

  @action
  void setDateOfBirth(DateTime dateOfBirth){
    this.dateOfBirth = dateOfBirth;
  }

  /*
  init target element
   */
  late Target target;

  @observable
  TypeTarget type = TypeTarget.holdWeight;

  @observable
  int targetWeight = 0;

  @observable
  double tempo = 0;

  @action
  void setType(TypeTarget type){
    this.type = type;
  }

  @action
  void setTargetWeight(int targetWeight){
    this.targetWeight = targetWeight;
  }

  @action
  void setTempo(double tempo){
    this.tempo = tempo;
  }

  /*
  name_auth_screen
   */
  @observable
  bool isButtonActiveNameAuth = false;

  @action
  void changeActiveNameAuth(String text){
    if(text.isNotEmpty){
      isButtonActiveNameAuth = true;
    }else{
      isButtonActiveNameAuth = false;
    }
  }

  /*
  datebirth_auth_screen
   */
  @observable
  DateTime? pickDate;

  @action
  void changeDate(DateTime calendar){
    pickDate = calendar;
  }

  /*
  parambody_auth_screen
   */
  var weightController = TextEditingController();
  var heightController = TextEditingController();

  @observable
  bool isButtonActiveParamBody = false;

  @action
  void checkActiveButtonParamBody(){
    print(heightController.text.isNotEmpty && weightController.text.isNotEmpty);

    if(heightController.text.isNotEmpty && weightController.text.isNotEmpty){
      isButtonActiveParamBody = true;
    }else{
      isButtonActiveParamBody = false;
    }
  }

  /*
   desired_auth_screen
   */
  @observable
  bool isButtonActiveDesired = false;

  @action
  void checkActiveButtonDesired(String text){
    if(text.isNotEmpty){
      isButtonActiveDesired = true;
    }else{
      isButtonActiveDesired = false;
    }
  }

  /*
   timetarget_auth_screen
   */
  @observable
  double currentSliderValue = 5;

  @action
  void changeSliderValue(double value){
    currentSliderValue = value;
  }

  void databaseEntry(){
    user = User(
        id: 1,
        username: username,
        gender: gender,
        weight: weight,
        height: height,
        dateOfBirth: dateOfBirth
    );
    
    target = Target(
        id: 1, 
        userId: 1, 
        type: type, 
        targetWeight: targetWeight == 0 ? weight : targetWeight,
        tempo: tempo
    );

    DBProvider.db.newUserObj(user);
    DBProvider.db.newTargetObj(target);
  }
}