import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helperguide/firebase/firebase_auth.dart';

class EditProfileProvider extends ChangeNotifier{
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();
  String image = "assets/placeholder.png";
  String url = " ";

  bool checkInfo() {
    return (email.text.isNotEmpty && password.text.isNotEmpty && fullName.text.isNotEmpty);
  }
  void updateImage(User? user) {
    url = user!.photoURL!;
    notifyListeners();
  }
  void updateInfo(User? user) async {
    if(checkInfo()) {
      if(user!.email != email.text) {
        await user.updateEmail(email.text);
      }
      if(user.displayName != fullName.text) {
        await user.updateDisplayName(fullName.text);
      }
      await user.updatePassword(password.text);
      user.reload();
      notifyListeners();
    }
  }
}