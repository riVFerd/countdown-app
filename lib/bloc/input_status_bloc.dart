import 'dart:async';

class InputStatusBloc {
  bool _isInputActive = true;

  InputStatusBloc() {
    _inputStatusController.sink.add(_isInputActive);
  }

  final _inputStatusController = StreamController<bool>();
  Stream<bool> get inputStatusStream => _inputStatusController.stream;

  void changeInputStatus() {
    _isInputActive = !_isInputActive;
    _inputStatusController.sink.add(_isInputActive);
    // print("Input status : $_isInputActive");
  }
}
