// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_states.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CalendarStates on _CalendarStates, Store {
  late final _$mealAtom = Atom(name: '_CalendarStates.meal', context: context);

  @override
  ObservableList<Meal> get meal {
    _$mealAtom.reportRead();
    return super.meal;
  }

  @override
  set meal(ObservableList<Meal> value) {
    _$mealAtom.reportWrite(value, super.meal, () {
      super.meal = value;
    });
  }

  late final _$fullEventsAtom =
      Atom(name: '_CalendarStates.fullEvents', context: context);

  @override
  ObservableList<CalendarEvent> get fullEvents {
    _$fullEventsAtom.reportRead();
    return super.fullEvents;
  }

  @override
  set fullEvents(ObservableList<CalendarEvent> value) {
    _$fullEventsAtom.reportWrite(value, super.fullEvents, () {
      super.fullEvents = value;
    });
  }

  late final _$shortEventsAtom =
      Atom(name: '_CalendarStates.shortEvents', context: context);

  @override
  ObservableList<CalendarEvent> get shortEvents {
    _$shortEventsAtom.reportRead();
    return super.shortEvents;
  }

  @override
  set shortEvents(ObservableList<CalendarEvent> value) {
    _$shortEventsAtom.reportWrite(value, super.shortEvents, () {
      super.shortEvents = value;
    });
  }

  late final _$yearAtom = Atom(name: '_CalendarStates.year', context: context);

  @override
  String get year {
    _$yearAtom.reportRead();
    return super.year;
  }

  @override
  set year(String value) {
    _$yearAtom.reportWrite(value, super.year, () {
      super.year = value;
    });
  }

  late final _$_CalendarStatesActionController =
      ActionController(name: '_CalendarStates', context: context);

  @override
  void initMeal() {
    final _$actionInfo = _$_CalendarStatesActionController.startAction(
        name: '_CalendarStates.initMeal');
    try {
      return super.initMeal();
    } finally {
      _$_CalendarStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setYearMonth(DateTime datetime) {
    final _$actionInfo = _$_CalendarStatesActionController.startAction(
        name: '_CalendarStates.setYearMonth');
    try {
      return super.setYearMonth(datetime);
    } finally {
      _$_CalendarStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
meal: ${meal},
fullEvents: ${fullEvents},
shortEvents: ${shortEvents},
year: ${year}
    ''';
  }
}
