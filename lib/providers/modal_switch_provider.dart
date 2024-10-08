import 'package:flutter/material.dart';

class ModalSwitchProvider with ChangeNotifier {
  bool _isSwitched = false;

  bool get isSwitched => _isSwitched;

  void toggleSwitch() {
    _isSwitched = !_isSwitched;
    notifyListeners(); // Notifica a los listeners
  }
  void switchClear(){
   _isSwitched = false; // Resetea el switch a false
   notifyListeners(); // Notifica a los listeners
  }
}
