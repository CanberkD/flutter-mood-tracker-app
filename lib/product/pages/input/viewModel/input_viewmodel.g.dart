// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InputViewModel on _InputViewModelBase, Store {
  late final _$activityScrollControllerAtom = Atom(
      name: '_InputViewModelBase.activityScrollController', context: context);

  @override
  ScrollController get activityScrollController {
    _$activityScrollControllerAtom.reportRead();
    return super.activityScrollController;
  }

  @override
  set activityScrollController(ScrollController value) {
    _$activityScrollControllerAtom
        .reportWrite(value, super.activityScrollController, () {
      super.activityScrollController = value;
    });
  }

  late final _$peopleScrollControllerAtom = Atom(
      name: '_InputViewModelBase.peopleScrollController', context: context);

  @override
  ScrollController get peopleScrollController {
    _$peopleScrollControllerAtom.reportRead();
    return super.peopleScrollController;
  }

  @override
  set peopleScrollController(ScrollController value) {
    _$peopleScrollControllerAtom
        .reportWrite(value, super.peopleScrollController, () {
      super.peopleScrollController = value;
    });
  }

  late final _$activityListAtom =
      Atom(name: '_InputViewModelBase.activityList', context: context);

  @override
  List<String> get activityList {
    _$activityListAtom.reportRead();
    return super.activityList;
  }

  @override
  set activityList(List<String> value) {
    _$activityListAtom.reportWrite(value, super.activityList, () {
      super.activityList = value;
    });
  }

  late final _$isActivityBoolListAtom =
      Atom(name: '_InputViewModelBase.isActivityBoolList', context: context);

  @override
  List<bool> get isActivityBoolList {
    _$isActivityBoolListAtom.reportRead();
    return super.isActivityBoolList;
  }

  @override
  set isActivityBoolList(List<bool> value) {
    _$isActivityBoolListAtom.reportWrite(value, super.isActivityBoolList, () {
      super.isActivityBoolList = value;
    });
  }

  late final _$peopleListAtom =
      Atom(name: '_InputViewModelBase.peopleList', context: context);

  @override
  List<String> get peopleList {
    _$peopleListAtom.reportRead();
    return super.peopleList;
  }

  @override
  set peopleList(List<String> value) {
    _$peopleListAtom.reportWrite(value, super.peopleList, () {
      super.peopleList = value;
    });
  }

  late final _$isPeoplesBoolListAtom =
      Atom(name: '_InputViewModelBase.isPeoplesBoolList', context: context);

  @override
  List<bool> get isPeoplesBoolList {
    _$isPeoplesBoolListAtom.reportRead();
    return super.isPeoplesBoolList;
  }

  @override
  set isPeoplesBoolList(List<bool> value) {
    _$isPeoplesBoolListAtom.reportWrite(value, super.isPeoplesBoolList, () {
      super.isPeoplesBoolList = value;
    });
  }

  late final _$_InputViewModelBaseActionController =
      ActionController(name: '_InputViewModelBase', context: context);

  @override
  void scrollToFirstActivty() {
    final _$actionInfo = _$_InputViewModelBaseActionController.startAction(
        name: '_InputViewModelBase.scrollToFirstActivty');
    try {
      return super.scrollToFirstActivty();
    } finally {
      _$_InputViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void scrollToFirstPeople() {
    final _$actionInfo = _$_InputViewModelBaseActionController.startAction(
        name: '_InputViewModelBase.scrollToFirstPeople');
    try {
      return super.scrollToFirstPeople();
    } finally {
      _$_InputViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addItemToActivitys(String item) {
    final _$actionInfo = _$_InputViewModelBaseActionController.startAction(
        name: '_InputViewModelBase.addItemToActivitys');
    try {
      return super.addItemToActivitys(item);
    } finally {
      _$_InputViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetActivityBoolList() {
    final _$actionInfo = _$_InputViewModelBaseActionController.startAction(
        name: '_InputViewModelBase.resetActivityBoolList');
    try {
      return super.resetActivityBoolList();
    } finally {
      _$_InputViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addItemToPeopleList(String item) {
    final _$actionInfo = _$_InputViewModelBaseActionController.startAction(
        name: '_InputViewModelBase.addItemToPeopleList');
    try {
      return super.addItemToPeopleList(item);
    } finally {
      _$_InputViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void activityAddButtonClicked(BuildContext context) {
    final _$actionInfo = _$_InputViewModelBaseActionController.startAction(
        name: '_InputViewModelBase.activityAddButtonClicked');
    try {
      return super.activityAddButtonClicked(context);
    } finally {
      _$_InputViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void peopleAddButtonClicked(BuildContext context) {
    final _$actionInfo = _$_InputViewModelBaseActionController.startAction(
        name: '_InputViewModelBase.peopleAddButtonClicked');
    try {
      return super.peopleAddButtonClicked(context);
    } finally {
      _$_InputViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
activityScrollController: ${activityScrollController},
peopleScrollController: ${peopleScrollController},
activityList: ${activityList},
isActivityBoolList: ${isActivityBoolList},
peopleList: ${peopleList},
isPeoplesBoolList: ${isPeoplesBoolList}
    ''';
  }
}
