import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/pages/authorization/auth_states.dart';
import 'package:nutrition_assistant/pages/authorization/name_auth_screen.dart';

import 'parambody_auth_screen.dart';


class DateBirthAuthScreen extends StatelessWidget{
  const DateBirthAuthScreen(AuthState authState);

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
                                "Понятно.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Укажите дату своего рождения",
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
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    elevation: 2,
                                  ),
                                  onPressed: () async{
                                    DateTime? calendar = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime(2010),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2010)
                                    );

                                    if(calendar != null){
                                      authState.setDateOfBirth(calendar);
                                      authState.changeDate(calendar);
                                    }
                                  },
                                  child: const Text(
                                    "Выбрать дату",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  )
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  authState.pickDate == null ? "ДД" : authState.pickDate!.day.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30
                                  ),
                                ),
                                Text(
                                  authState.pickDate == null ? "ММ" : authState.pickDate!.month.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30
                                  ),
                                ),
                                Text(
                                  authState.pickDate == null ? "ГГГГ" : authState.pickDate!.year.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30
                                  ),
                                ),
                              ],
                            ),
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
                                  onPressed: authState.pickDate != null ? () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                BodyAuthScreen(authState)
                                        )
                                    );
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
                )
              ],
            ),
        ),
    );
  }
}