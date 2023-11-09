// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_states.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStates on _UserStates, Store {
  Computed<double>? _$progressComputed;

  @override
  double get progress => (_$progressComputed ??=
          Computed<double>(() => super.progress, name: '_UserStates.progress'))
      .value;
  Computed<int>? _$progressPercentageComputed;

  @override
  int get progressPercentage => (_$progressPercentageComputed ??= Computed<int>(
          () => super.progressPercentage,
          name: '_UserStates.progressPercentage'))
      .value;

  late final _$targetAtom = Atom(name: '_UserStates.target', context: context);

  @override
  Target get target {
    _$targetAtom.reportRead();
    return super.target;
  }

  @override
  set target(Target value) {
    _$targetAtom.reportWrite(value, super.target, () {
      super.target = value;
    });
  }

  late final _$lastPointAtom =
      Atom(name: '_UserStates.lastPoint', context: context);

  @override
  ControlPoint get lastPoint {
    _$lastPointAtom.reportRead();
    return super.lastPoint;
  }

  @override
  set lastPoint(ControlPoint value) {
    _$lastPointAtom.reportWrite(value, super.lastPoint, () {
      super.lastPoint = value;
    });
  }

  late final _$userWeightAtom =
      Atom(name: '_UserStates.userWeight', context: context);

  @override
  int get userWeight {
    _$userWeightAtom.reportRead();
    return super.userWeight;
  }

  @override
  set userWeight(int value) {
    _$userWeightAtom.reportWrite(value, super.userWeight, () {
      super.userWeight = value;
    });
  }

  late final _$indexNewTargetAtom =
      Atom(name: '_UserStates.indexNewTarget', context: context);

  @override
  int get indexNewTarget {
    _$indexNewTargetAtom.reportRead();
    return super.indexNewTarget;
  }

  @override
  set indexNewTarget(int value) {
    _$indexNewTargetAtom.reportWrite(value, super.indexNewTarget, () {
      super.indexNewTarget = value;
    });
  }

  late final _$currentSliderValueAtom =
      Atom(name: '_UserStates.currentSliderValue', context: context);

  @override
  double get currentSliderValue {
    _$currentSliderValueAtom.reportRead();
    return super.currentSliderValue;
  }

  @override
  set currentSliderValue(double value) {
    _$currentSliderValueAtom.reportWrite(value, super.currentSliderValue, () {
      super.currentSliderValue = value;
    });
  }

  late final _$activeButtonChangeAtom =
      Atom(name: '_UserStates.activeButtonChange', context: context);

  @override
  bool get activeButtonChange {
    _$activeButtonChangeAtom.reportRead();
    return super.activeButtonChange;
  }

  @override
  set activeButtonChange(bool value) {
    _$activeButtonChangeAtom.reportWrite(value, super.activeButtonChange, () {
      super.activeButtonChange = value;
    });
  }

  late final _$_UserStatesActionController =
      ActionController(name: '_UserStates', context: context);

  @override
  void setTarget(Target target) {
    final _$actionInfo = _$_UserStatesActionController.startAction(
        name: '_UserStates.setTarget');
    try {
      return super.setTarget(target);
    } finally {
      _$_UserStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTarget() {
    final _$actionInfo = _$_UserStatesActionController.startAction(
        name: '_UserStates.changeTarget');
    try {
      return super.changeTarget();
    } finally {
      _$_UserStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initUserWeight(int userWeight) {
    final _$actionInfo = _$_UserStatesActionController.startAction(
        name: '_UserStates.initUserWeight');
    try {
      return super.initUserWeight(userWeight);
    } finally {
      _$_UserStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getLastPoint() {
    final _$actionInfo = _$_UserStatesActionController.startAction(
        name: '_UserStates.getLastPoint');
    try {
      return super.getLastPoint();
    } finally {
      _$_UserStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIndexNewTarget(String value) {
    final _$actionInfo = _$_UserStatesActionController.startAction(
        name: '_UserStates.changeIndexNewTarget');
    try {
      return super.changeIndexNewTarget(value);
    } finally {
      _$_UserStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSliderValue(double value) {
    final _$actionInfo = _$_UserStatesActionController.startAction(
        name: '_UserStates.changeSliderValue');
    try {
      return super.changeSliderValue(value);
    } finally {
      _$_UserStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void checkActiveButton(String value) {
    final _$actionInfo = _$_UserStatesActionController.startAction(
        name: '_UserStates.checkActiveButton');
    try {
      return super.checkActiveButton(value);
    } finally {
      _$_UserStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
target: ${target},
lastPoint: ${lastPoint},
userWeight: ${userWeight},
indexNewTarget: ${indexNewTarget},
currentSliderValue: ${currentSliderValue},
activeButtonChange: ${activeButtonChange},
progress: ${progress},
progressPercentage: ${progressPercentage}
    ''';
  }
}
