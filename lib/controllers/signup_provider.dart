import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  bool check = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();

  void setCheck(bool value) {
    check = value;
    notifyListeners();
  }

  bool checkInfo() {
    return (check && email.text.isNotEmpty && password.text.isNotEmpty && fullName.text.isNotEmpty);
  }
  void resetControllers() {
    email.clear();
    password.clear();
    fullName.clear();
    notifyListeners();
  }
}