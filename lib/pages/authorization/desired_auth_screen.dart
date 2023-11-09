import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/pages/authorization/auth_states.dart';
import 'package:nutrition_assistant/pages/authorization/name_auth_screen.dart';
import 'package:nutrition_assistant/pages/authorization/timetarget_auth_screen.dart';

class DesiredAuthScreen extends StatelessWidget{
  const DesiredAuthScreen(AuthState authState);

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
                          "Отлично почти готов!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Укажите желаемый вес",
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
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Желаемый вес (кг)'
                              ),
                              onChanged: (text){
                                authState.setTargetWeight(int.parse(text == "" ? "0" : text));
                                authState.checkActiveButtonDesired(text);
                              },
                            ),
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
                            onPressed: authState.isButtonActiveDesired ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          TimeTargetAuthScreen(authState)
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
            ),
          ],
        ),
      ),
    );
  }
}