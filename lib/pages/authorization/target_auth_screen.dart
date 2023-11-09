import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/models/target.dart';
import 'package:nutrition_assistant/pages/authorization/auth_states.dart';
import 'package:nutrition_assistant/pages/authorization/name_auth_screen.dart';

import 'gender_auth_screen.dart';

class TargetAuthScreen extends StatelessWidget{
  const TargetAuthScreen(AuthState authState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              "Давайте познакомимся!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Какова ваша цель?",
                          style: TextStyle(
                              fontFamily: 'Playfair Display',
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  minimumSize: const Size.fromHeight(80),
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  elevation: 2,
                                ),
                                onPressed: (){
                                  authState.setType(TypeTarget.loseWeight);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              GenderAuthScreen(authState)
                                      )
                                  );
                                },
                                child: const Text(
                                  "Сбросить вес",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  minimumSize: const Size.fromHeight(80),
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  elevation: 2,
                                ),
                                onPressed: (){
                                  authState.setType(TypeTarget.holdWeight);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              GenderAuthScreen(authState)
                                      )
                                  );
                                },
                                child: const Text(
                                  "Поддерживать вес",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  minimumSize: const Size.fromHeight(80),
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  elevation: 2,
                                ),
                                onPressed: (){
                                  authState.setType(TypeTarget.gainWeight);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              GenderAuthScreen(authState)
                                      )
                                  );
                                },
                                child: const Text(
                                  "Набрать вес",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                            )
                        ),
                        const Spacer(flex: 1),
                        const Text(
                            "Мы используем эти сведения для расчетов и предоставления "
                                "вам ежедневных персональных рекомендаций",
                            textAlign: TextAlign.center),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ),
              )
            ],
          ),
      ),
    );
  }
}