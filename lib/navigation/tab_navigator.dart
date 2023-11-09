import 'package:flutter/material.dart';

import '../pages/calendar/calendar.dart';
import '../pages/cookbook/cookbook.dart';
import '../pages/add_meal/add_meal.dart';
import '../pages/progress/progress.dart';
import '../pages/user/user_screen.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({super.key, required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {

    Widget child = const Calendar();
    switch(tabItem){
      case 'Calendar':
        child = const Calendar();
        break;
      case 'Cookbook':
        child = const CookBook();
        break;
      case 'AddMeal':
        child = const AddMeal();
        break;
      case 'Progress':
        child = const Progress();
        break;
      case 'User':
        child = const UserScreen();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );
  }
}
