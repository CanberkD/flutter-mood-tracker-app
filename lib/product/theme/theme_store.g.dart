// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeStore on _ThemeStoreBase, Store {
  late final _$themeDataAtom =
      Atom(name: '_ThemeStoreBase.themeData', context: context);

  @override
  ThemeData get themeData {
    _$themeDataAtom.reportRead();
    return super.themeData;
  }

  @override
  set themeData(ThemeData value) {
    _$themeDataAtom.reportWrite(value, super.themeData, () {
      super.themeData = value;
    });
  }

  late final _$isThemeLightAtom =
      Atom(name: '_ThemeStoreBase.isThemeLight', context: context);

  @override
  bool get isThemeLight {
    _$isThemeLightAtom.reportRead();
    return super.isThemeLight;
  }

  @override
  set isThemeLight(bool value) {
    _$isThemeLightAtom.reportWrite(value, super.isThemeLight, () {
      super.isThemeLight = value;
    });
  }

  late final _$_ThemeStoreBaseActionController =
      ActionController(name: '_ThemeStoreBase', context: context);

  @override
  void switchTheme() {
    final _$actionInfo = _$_ThemeStoreBaseActionController.startAction(
        name: '_ThemeStoreBase.switchTheme');
    try {
      return super.switchTheme();
    } finally {
      _$_ThemeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
themeData: ${themeData},
isThemeLight: ${isThemeLight}
    ''';
  }
}
