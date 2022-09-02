// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InputViewModel on _InputViewModelBase, Store {
  late final _$isButtonSelectedListAtom =
      Atom(name: '_InputViewModelBase.isButtonSelectedList', context: context);

  @override
  List<bool> get isButtonSelectedList {
    _$isButtonSelectedListAtom.reportRead();
    return super.isButtonSelectedList;
  }

  @override
  set isButtonSelectedList(List<bool> value) {
    _$isButtonSelectedListAtom.reportWrite(value, super.isButtonSelectedList,
        () {
      super.isButtonSelectedList = value;
    });
  }

  @override
  String toString() {
    return '''
isButtonSelectedList: ${isButtonSelectedList}
    ''';
  }
}
