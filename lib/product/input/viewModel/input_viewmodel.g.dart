// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InputViewModel on _InputViewModelBase, Store {
  late final _$isHappySelectedAtom =
      Atom(name: '_InputViewModelBase.isHappySelected', context: context);

  @override
  bool get isHappySelected {
    _$isHappySelectedAtom.reportRead();
    return super.isHappySelected;
  }

  @override
  set isHappySelected(bool value) {
    _$isHappySelectedAtom.reportWrite(value, super.isHappySelected, () {
      super.isHappySelected = value;
    });
  }

  late final _$isNotrSelectedAtom =
      Atom(name: '_InputViewModelBase.isNotrSelected', context: context);

  @override
  bool get isNotrSelected {
    _$isNotrSelectedAtom.reportRead();
    return super.isNotrSelected;
  }

  @override
  set isNotrSelected(bool value) {
    _$isNotrSelectedAtom.reportWrite(value, super.isNotrSelected, () {
      super.isNotrSelected = value;
    });
  }

  late final _$isSadSelectedAtom =
      Atom(name: '_InputViewModelBase.isSadSelected', context: context);

  @override
  bool get isSadSelected {
    _$isSadSelectedAtom.reportRead();
    return super.isSadSelected;
  }

  @override
  set isSadSelected(bool value) {
    _$isSadSelectedAtom.reportWrite(value, super.isSadSelected, () {
      super.isSadSelected = value;
    });
  }

  late final _$_InputViewModelBaseActionController =
      ActionController(name: '_InputViewModelBase', context: context);

  @override
  void buttonPressed(int index) {
    final _$actionInfo = _$_InputViewModelBaseActionController.startAction(
        name: '_InputViewModelBase.buttonPressed');
    try {
      return super.buttonPressed(index);
    } finally {
      _$_InputViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isHappySelected: ${isHappySelected},
isNotrSelected: ${isNotrSelected},
isSadSelected: ${isSadSelected}
    ''';
  }
}
