import 'package:mobx/mobx.dart';
part 'input_viewmodel.g.dart';

class InputViewModel = _InputViewModelBase with _$InputViewModel;

abstract class _InputViewModelBase with Store {
  @observable
  List<bool> isButtonSelectedList = [true, false, false];

}