// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_states.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProgressState on _ProgressState, Store {
  late final _$calendarViewAtom =
      Atom(name: '_ProgressState.calendarView', context: context);

  @override
  MyCalendar get calendarView {
    _$calendarViewAtom.reportRead();
    return super.calendarView;
  }

  @override
  set calendarView(MyCalendar value) {
    _$calendarViewAtom.reportWrite(value, super.calendarView, () {
      super.calendarView = value;
    });
  }

  late final _$progressAtom =
      Atom(name: '_ProgressState.progress', context: context);

  @override
  int? get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(int? value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  late final _$targetUserAtom =
      Atom(name: '_ProgressState.targetUser', context: context);

  @override
  Target get targetUser {
    _$targetUserAtom.reportRead();
    return super.targetUser;
  }

  @override
  set targetUser(Target value) {
    _$targetUserAtom.reportWrite(value, super.targetUser, () {
      super.targetUser = value;
    });
  }

  late final _$flSpotsAtom =
      Atom(name: '_ProgressState.flSpots', context: context);

  @override
  ObservableList<FlSpot> get flSpots {
    _$flSpotsAtom.reportRead();
    return super.flSpots;
  }

  @override
  set flSpots(ObservableList<FlSpot> value) {
    _$flSpotsAtom.reportWrite(value, super.flSpots, () {
      super.flSpots = value;
    });
  }

  late final _$controlPointsAtom =
      Atom(name: '_ProgressState.controlPoints', context: context);

  @override
  ObservableList<ControlPoint> get controlPoints {
    _$controlPointsAtom.reportRead();
    return super.controlPoints;
  }

  @override
  set controlPoints(ObservableList<ControlPoint> value) {
    _$controlPointsAtom.reportWrite(value, super.controlPoints, () {
      super.controlPoints = value;
    });
  }

  late final _$_ProgressStateActionController =
      ActionController(name: '_ProgressState', context: context);

  @override
  void changeCalendarView(Set<MyCalendar> newSelection) {
    final _$actionInfo = _$_ProgressStateActionController.startAction(
        name: '_ProgressState.changeCalendarView');
    try {
      return super.changeCalendarView(newSelection);
    } finally {
      _$_ProgressStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getTargetUser() {
    final _$actionInfo = _$_ProgressStateActionController.startAction(
        name: '_ProgressState.getTargetUser');
    try {
      return super.getTargetUser();
    } finally {
      _$_ProgressStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initControlPoint() {
    final _$actionInfo = _$_ProgressStateActionController.startAction(
        name: '_ProgressState.initControlPoint');
    try {
      return super.initControlPoint();
    } finally {
      _$_ProgressStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fillByType() {
    final _$actionInfo = _$_ProgressStateActionController.startAction(
        name: '_ProgressState.fillByType');
    try {
      return super.fillByType();
    } finally {
      _$_ProgressStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
calendarView: ${calendarView},
progress: ${progress},
targetUser: ${targetUser},
flSpots: ${flSpots},
controlPoints: ${controlPoints}
    ''';
  }
}
