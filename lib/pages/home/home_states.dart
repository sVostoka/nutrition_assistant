import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrition_assistant/navigation/tab_navigator.dart';
import 'package:nutrition_assistant/pages/home/home_screen.dart';

part 'home_states.g.dart';

class HomeStates = _HomeStates with _$HomeStates;

abstract class _HomeStates with Store{

  @observable
  String currentPage = "Calendar";

  @observable
  int selectedIndex = 0;

  @action
  void selectTab(index){
    currentPage = pageKeys[index];
    selectedIndex = index;
  }

  /*
  Non observable
   */
  List<String> pageKeys = ["Calendar", "Cookbook", "AddMeal", "Progress", "User"];

  final items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month),
      label: 'Календарь',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.book_outlined),
      label: 'Рецепты',
    ),
    const BottomNavigationBarItem(
        icon: SizedBox.shrink(),
        label: ''
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.query_stats_outlined),
      label: 'Прогресс',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: 'Кабинет',
    ),
  ];

  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Calendar": GlobalKey<NavigatorState>(),
    "Cookbook": GlobalKey<NavigatorState>(),
    "AddMeal": GlobalKey<NavigatorState>(),
    "Progress": GlobalKey<NavigatorState>(),
    "User": GlobalKey<NavigatorState>(),
  };

  final widgets = <Widget> [
    _buildOffstageNavigator("Calendar"),
    _buildOffstageNavigator("Cookbook"),
    _buildOffstageNavigator("AddMeal"),
    _buildOffstageNavigator("Progress"),
    _buildOffstageNavigator("User"),
  ];

  Future<bool> backRoute() async {
    final bool isFirstRouteInCurrentTab = !await _navigatorKeys[currentPage]!.currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      if (currentPage != "Calendar") {
        selectTabNoAction("Calendar", 1);
        return false;
      }
    }
    return isFirstRouteInCurrentTab;
  }

  void onChange(index){
    selectTabNoAction(pageKeys[index], index);
  }

  void selectTabNoAction(String tabItem, int index) {
    if(tabItem == currentPage ){
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      selectTab(index);
    }
  }

  static Widget _buildOffstageNavigator(String tabItem) {
    return Observer(
        builder: (_) => Offstage(
          offstage: homeStates.currentPage != tabItem,
          child: TabNavigator(
            navigatorKey: homeStates._navigatorKeys[tabItem]!,
            tabItem: tabItem,
          ),
        ));
  }
}

