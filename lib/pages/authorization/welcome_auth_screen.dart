import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'name_auth_screen.dart';

class WelcomeAuthScreen extends StatelessWidget{
  const WelcomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/loginBackground.jpg'),
                    fit: BoxFit.cover
                )
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Ваш путь к здоровому питанию',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Playfair Display',
                              fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: const Size.fromHeight(50),
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Playfair Display',
                                  fontSize: 13),
                              elevation: 3,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const NameAuthScreen()
                                  )
                              );
                            },
                            child: const Text("НАЧАТЬ"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
      )
    );
  }
}