import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/pages/authorization/target_auth_screen.dart';

import 'auth_states.dart';

final authState = AuthState();

class NameAuthScreen extends StatelessWidget {
  const NameAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: Column(
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
                        "Здравствуйте!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Введите ваше полное имя",
                    style: TextStyle(
                        fontFamily: 'Playfair Display',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Observer(
                      builder: (_) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10),
                            child: TextField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Ваше имя'),
                              onChanged: (text) {
                                authState.setUserName(text);
                                authState.changeActiveNameAuth(text);
                              },
                            ),
                          )),
                  const Spacer(flex: 1),
                  Observer(
                    builder: (_) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size.fromHeight(40),
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              elevation: 2,
                            ),
                            onPressed: authState.isButtonActiveNameAuth ? () {
                              Navigator.push( context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          TargetAuthScreen(authState)));
                            } : null,
                            child: const Text(
                              "Далее",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
