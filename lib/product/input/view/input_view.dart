import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/product/input/view/widgets.dart';
import 'package:flutter_mood_tracker/product/input/viewModel/input_viewmodel.dart';

class InputView extends StatefulWidget {
  const InputView({Key? key}) : super(key: key);
  @override
  State<InputView> createState() => _InputViewState();
}

class _InputViewState extends State<InputView> {
  final InputViewModel _model = InputViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const ButtonClose(),
          const MainHeader(),
          const MoodSelectionTitle(),
          MoodSelectionWidget(model: _model),
          const ActivitySelectionTitle(),
          ActivitySelectionGroup(model: _model),
          const PeopleSelectionTitle(),
          PeopleSelection(model: _model),
          SaveButton(model: _model)
          ],
      ),
    );
  }

}
