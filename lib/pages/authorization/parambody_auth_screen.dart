import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/models/target.dart';
import 'package:nutrition_assistant/pages/authorization/auth_states.dart';
import 'package:nutrition_assistant/pages/authorization/desired_auth_screen.dart';
import 'package:nutrition_assistant/pages/authorization/name_auth_screen.dart';
import 'package:nutrition_assistant/pages/home/home_screen.dart';

class BodyAuthScreen extends StatelessWidget{
  const BodyAuthScreen(AuthState authState);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFE4E1),
          elevation: 0,
        ),
        body: Container(
            color: const Color(0xFFFFE4E1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: Observer(
                      builder: (_) => Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Image(
                                width: 30,
                                height: 30,
                                image: AssetImage('assets/icons/salad.png'),
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Спасибо! Отличная работа!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Укажите свой рост и вес",
                            style: TextStyle(
                                fontFamily: 'Playfair Display',
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                              child: Column(
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    controller: authState.heightController,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Рост (см)'
                                    ),
                                    onChanged: (value){
                                      authState.setHeight(int.parse(value == "" ? "0" : value));
                                      authState.checkActiveButtonParamBody();
                                    },
                                  ),
                                  const SizedBox(height: 40),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    controller: authState.weightController,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Вес (кг)'
                                    ),
                                    onChanged: (value){
                                      authState.setWeight(int.parse(value == "" ? "0" : value));
                                      authState.checkActiveButtonParamBody();
                                    },
                                  )
                                ],
                              )
                          ),
                          const Spacer(flex: 1),
                          const Text(
                            "Мы используем эти сведения для расчетов и "
                                "предроставления вам ежедневных персональных "
                                "рекомендаций.",
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    minimumSize: const Size.fromHeight(40),
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    elevation: 2,
                                  ),
                                  onPressed: authState.isButtonActiveParamBody ? () {
                                    if(authState.type != TypeTarget.holdWeight){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  DesiredAuthScreen(authState)
                                          )
                                      );
                                    }else{
                                      authState.databaseEntry();
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                                        return HomeScreen();
                                      }));
                                    }
                                  } : null,
                                  child: const Text(
                                    "Далее",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  )
                              )
                          ),
                        ],
                      ),
                    ),
                ),
              ],
            ),
        ),
    );
  }
}