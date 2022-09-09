// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homepage_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageViewModel on _HomePageViewModelBase, Store {
  late final _$dayIndexAtom =
      Atom(name: '_HomePageViewModelBase.dayIndex', context: context);

  @override
  int get dayIndex {
    _$dayIndexAtom.reportRead();
    return super.dayIndex;
  }

  @override
  set dayIndex(int value) {
    _$dayIndexAtom.reportWrite(value, super.dayIndex, () {
      super.dayIndex = value;
    });
  }

  late final _$monthIndexAtom =
      Atom(name: '_HomePageViewModelBase.monthIndex', context: context);

  @override
  int get monthIndex {
    _$monthIndexAtom.reportRead();
    return super.monthIndex;
  }

  @override
  set monthIndex(int value) {
    _$monthIndexAtom.reportWrite(value, super.monthIndex, () {
      super.monthIndex = value;
    });
  }

  late final _$yearIndexAtom =
      Atom(name: '_HomePageViewModelBase.yearIndex', context: context);

  @override
  int get yearIndex {
    _$yearIndexAtom.reportRead();
    return super.yearIndex;
  }

  @override
  set yearIndex(int value) {
    _$yearIndexAtom.reportWrite(value, super.yearIndex, () {
      super.yearIndex = value;
    });
  }

  late final _$recordedListAtom =
      Atom(name: '_HomePageViewModelBase.recordedList', context: context);

  @override
  ObservableList<RecordedMoodModel> get recordedList {
    _$recordedListAtom.reportRead();
    return super.recordedList;
  }

  @override
  set recordedList(ObservableList<RecordedMoodModel> value) {
    _$recordedListAtom.reportWrite(value, super.recordedList, () {
      super.recordedList = value;
    });
  }

  @override
  String toString() {
    return '''
dayIndex: ${dayIndex},
monthIndex: ${monthIndex},
yearIndex: ${yearIndex},
recordedList: ${recordedList}
    ''';
  }
}
