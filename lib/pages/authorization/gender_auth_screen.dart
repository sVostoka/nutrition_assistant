import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/models/user.dart';
import 'package:nutrition_assistant/pages/authorization/auth_states.dart';
import 'package:nutrition_assistant/pages/authorization/name_auth_screen.dart';

import 'datebirth_auth_screen.dart';

class GenderAuthScreen extends StatelessWidget{
  const GenderAuthScreen(AuthState authState);

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
                                "Отлично продолжим.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Для человека какого пола следует рассчитывать рекоменации?",
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
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    minimumSize: const Size.fromHeight(80),
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    elevation: 2,
                                  ),
                                  child: const Text(
                                    "Женский",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  onPressed: (){
                                    authState.setGender(Gender.woman);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                DateBirthAuthScreen(authState)
                                        )
                                    );
                                  },
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
                                  child: const Text(
                                    "Мужской",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  onPressed: (){
                                    authState.setGender(Gender.man);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                DateBirthAuthScreen(authState)
                                        )
                                    );
                                  },
                              )
                          ),
                          const Spacer(flex: 1),
                          const Text(
                            "Пол влияет на скорость метаболизма. Вот почему эта "
                                "информация нужна для расчета суточной нормы.",
                            textAlign: TextAlign.center,
                          ),
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