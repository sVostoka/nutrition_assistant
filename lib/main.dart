import 'package:flutter/material.dart';
import 'package:nutrition_assistant/core/theme.dart';
import 'package:nutrition_assistant/pages/home/home_screen.dart';

import 'database/DBProvider.dart';
import 'models/user.dart';
import 'pages/authorization/welcome_auth_screen.dart';

void main() {
  runApp(const NutritionAssistant());
}

class NutritionAssistant extends StatelessWidget {
  const NutritionAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<User>(
        future: DBProvider.db.getUser(),
        builder: (BuildContext context, AsyncSnapshot<User> user){
          if (user.hasData){
            if(user.data!.id == 0){
              return const WelcomeAuthScreen();
            }else{
              return HomeScreen();
            }
          }else{
            return Container(color: Colors.white);
          }
        }
      ),
      theme: basicTheme(),
    );
  }
}