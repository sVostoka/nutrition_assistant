import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/widgets/tapbar_clipper.dart';
import 'home_states.dart';

final homeStates = HomeStates();

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => WillPopScope(
          onWillPop: homeStates.backRoute,
          child: Scaffold(
            body: Stack(
                children: homeStates.widgets
            ),
            bottomNavigationBar: TabBarClipper(
              selectedIndex: homeStates.selectedIndex,
              onChange: homeStates.onChange,
              items: homeStates.items,
            ),
            floatingActionButton: Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
              child: FloatingActionButton(
                onPressed: () => homeStates.onChange(2),
                elevation: 0,
                highlightElevation: 0,
                child: const Icon(Icons.add),
              )),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          ),
        )
    );
  }
}