import 'package:flutter/material.dart';

class SwitchStateProvider with ChangeNotifier {
  bool _switch1 = false;
  bool _switch2 = false;
  bool _switch3 = false;

  bool get switch1 => _switch1;
  bool get switch2 => _switch2;
  bool get switch3 => _switch3;

  void toggleSwitch1(bool value) {
    _switch1 = value;
    notifyListeners();
  }

  void toggleSwitch2(bool value) {
    _switch2 = value;
    notifyListeners();
  }

  void toggleSwitch3(bool value) {
    _switch3 = value;
    notifyListeners();
  }
}
