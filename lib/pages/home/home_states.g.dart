// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_states.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStates on _HomeStates, Store {
  late final _$currentPageAtom =
      Atom(name: '_HomeStates.currentPage', context: context);

  @override
  String get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(String value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$selectedIndexAtom =
      Atom(name: '_HomeStates.selectedIndex', context: context);

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  late final _$_HomeStatesActionController =
      ActionController(name: '_HomeStates', context: context);

  @override
  void selectTab(dynamic index) {
    final _$actionInfo = _$_HomeStatesActionController.startAction(
        name: '_HomeStates.selectTab');
    try {
      return super.selectTab(index);
    } finally {
      _$_HomeStatesActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage},
selectedIndex: ${selectedIndex}
    ''';
  }
}
