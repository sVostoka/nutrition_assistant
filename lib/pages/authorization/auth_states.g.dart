// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_states.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthState on _AuthState, Store {
  late final _$usernameAtom =
      Atom(name: '_AuthState.username', context: context);

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$genderAtom = Atom(name: '_AuthState.gender', context: context);

  @override
  Gender get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(Gender value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$weightAtom = Atom(name: '_AuthState.weight', context: context);

  @override
  int get weight {
    _$weightAtom.reportRead();
    return super.weight;
  }

  @override
  set weight(int value) {
    _$weightAtom.reportWrite(value, super.weight, () {
      super.weight = value;
    });
  }

  late final _$heightAtom = Atom(name: '_AuthState.height', context: context);

  @override
  int get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(int value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  late final _$dateOfBirthAtom =
      Atom(name: '_AuthState.dateOfBirth', context: context);

  @override
  DateTime get dateOfBirth {
    _$dateOfBirthAtom.reportRead();
    return super.dateOfBirth;
  }

  @override
  set dateOfBirth(DateTime value) {
    _$dateOfBirthAtom.reportWrite(value, super.dateOfBirth, () {
      super.dateOfBirth = value;
    });
  }

  late final _$typeAtom = Atom(name: '_AuthState.type', context: context);

  @override
  TypeTarget get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(TypeTarget value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  late final _$targetWeightAtom =
      Atom(name: '_AuthState.targetWeight', context: context);

  @override
  int get targetWeight {
    _$targetWeightAtom.reportRead();
    return super.targetWeight;
  }

  @override
  set targetWeight(int value) {
    _$targetWeightAtom.reportWrite(value, super.targetWeight, () {
      super.targetWeight = value;
    });
  }

  late final _$tempoAtom = Atom(name: '_AuthState.tempo', context: context);

  @override
  double get tempo {
    _$tempoAtom.reportRead();
    return super.tempo;
  }

  @override
  set tempo(double value) {
    _$tempoAtom.reportWrite(value, super.tempo, () {
      super.tempo = value;
    });
  }

  late final _$isButtonActiveNameAuthAtom =
      Atom(name: '_AuthState.isButtonActiveNameAuth', context: context);

  @override
  bool get isButtonActiveNameAuth {
    _$isButtonActiveNameAuthAtom.reportRead();
    return super.isButtonActiveNameAuth;
  }

  @override
  set isButtonActiveNameAuth(bool value) {
    _$isButtonActiveNameAuthAtom
        .reportWrite(value, super.isButtonActiveNameAuth, () {
      super.isButtonActiveNameAuth = value;
    });
  }

  late final _$pickDateAtom =
      Atom(name: '_AuthState.pickDate', context: context);

  @override
  DateTime? get pickDate {
    _$pickDateAtom.reportRead();
    return super.pickDate;
  }

  @override
  set pickDate(DateTime? value) {
    _$pickDateAtom.reportWrite(value, super.pickDate, () {
      super.pickDate = value;
    });
  }

  late final _$isButtonActiveParamBodyAtom =
      Atom(name: '_AuthState.isButtonActiveParamBody', context: context);

  @override
  bool get isButtonActiveParamBody {
    _$isButtonActiveParamBodyAtom.reportRead();
    return super.isButtonActiveParamBody;
  }

  @override
  set isButtonActiveParamBody(bool value) {
    _$isButtonActiveParamBodyAtom
        .reportWrite(value, super.isButtonActiveParamBody, () {
      super.isButtonActiveParamBody = value;
    });
  }

  late final _$isButtonActiveDesiredAtom =
      Atom(name: '_AuthState.isButtonActiveDesired', context: context);

  @override
  bool get isButtonActiveDesired {
    _$isButtonActiveDesiredAtom.reportRead();
    return super.isButtonActiveDesired;
  }

  @override
  set isButtonActiveDesired(bool value) {
    _$isButtonActiveDesiredAtom.reportWrite(value, super.isButtonActiveDesired,
        () {
      super.isButtonActiveDesired = value;
    });
  }

  late final _$currentSliderValueAtom =
      Atom(name: '_AuthState.currentSliderValue', context: context);

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

  late final _$_AuthStateActionController =
      ActionController(name: '_AuthState', context: context);

  @override
  void setUserName(String username) {
    final _$actionInfo = _$_AuthStateActionController.startAction(
        name: '_AuthState.setUserName');
    try {
      return super.setUserName(username);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGender(Gender gender) {
    final _$actionInfo =
        _$_AuthStateActionController.startAction(name: '_AuthState.setGender');
    try {
      return super.setGender(gender);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWeight(int weight) {
    final _$actionInfo =
        _$_AuthStateActionController.startAction(name: '_AuthState.setWeight');
    try {
      return super.setWeight(weight);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHeight(int height) {
    final _$actionInfo =
        _$_AuthStateActionController.startAction(name: '_AuthState.setHeight');
    try {
      return super.setHeight(height);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDateOfBirth(DateTime dateOfBirth) {
    final _$actionInfo = _$_AuthStateActionController.startAction(
        name: '_AuthState.setDateOfBirth');
    try {
      return super.setDateOfBirth(dateOfBirth);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setType(TypeTarget type) {
    final _$actionInfo =
        _$_AuthStateActionController.startAction(name: '_AuthState.setType');
    try {
      return super.setType(type);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTargetWeight(int targetWeight) {
    final _$actionInfo = _$_AuthStateActionController.startAction(
        name: '_AuthState.setTargetWeight');
    try {
      return super.setTargetWeight(targetWeight);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTempo(double tempo) {
    final _$actionInfo =
        _$_AuthStateActionController.startAction(name: '_AuthState.setTempo');
    try {
      return super.setTempo(tempo);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeActiveNameAuth(String text) {
    final _$actionInfo = _$_AuthStateActionController.startAction(
        name: '_AuthState.changeActiveNameAuth');
    try {
      return super.changeActiveNameAuth(text);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeDate(DateTime calendar) {
    final _$actionInfo =
        _$_AuthStateActionController.startAction(name: '_AuthState.changeDate');
    try {
      return super.changeDate(calendar);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void checkActiveButtonParamBody() {
    final _$actionInfo = _$_AuthStateActionController.startAction(
        name: '_AuthState.checkActiveButtonParamBody');
    try {
      return super.checkActiveButtonParamBody();
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void checkActiveButtonDesired(String text) {
    final _$actionInfo = _$_AuthStateActionController.startAction(
        name: '_AuthState.checkActiveButtonDesired');
    try {
      return super.checkActiveButtonDesired(text);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSliderValue(double value) {
    final _$actionInfo = _$_AuthStateActionController.startAction(
        name: '_AuthState.changeSliderValue');
    try {
      return super.changeSliderValue(value);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
username: ${username},
gender: ${gender},
weight: ${weight},
height: ${height},
dateOfBirth: ${dateOfBirth},
type: ${type},
targetWeight: ${targetWeight},
tempo: ${tempo},
isButtonActiveNameAuth: ${isButtonActiveNameAuth},
pickDate: ${pickDate},
isButtonActiveParamBody: ${isButtonActiveParamBody},
isButtonActiveDesired: ${isButtonActiveDesired},
currentSliderValue: ${currentSliderValue}
    ''';
  }
}
