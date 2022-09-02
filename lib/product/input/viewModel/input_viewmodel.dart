import 'package:mobx/mobx.dart';
part 'input_viewmodel.g.dart';

class InputViewModel = _InputViewModelBase with _$InputViewModel;

abstract class _InputViewModelBase with Store {
  @observable
  bool isHappySelected = true;
  @observable
  bool isNotrSelected = false;
  @observable
  bool isSadSelected = false;
  
  @action
  void buttonPressed(int index){
    isHappySelected = false;
    isNotrSelected = false;
    isSadSelected = false;
    if(index == 1) {
      isHappySelected = !isHappySelected;
    } else if(index == 2) {
      isNotrSelected = !isNotrSelected;
    }
    else if(index == 3){
      isSadSelected = !isSadSelected;
    }
  }

}