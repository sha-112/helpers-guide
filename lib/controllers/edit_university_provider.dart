import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:helperguide/modules/university_activitiy.dart';

class EditUniversityProvider extends ChangeNotifier{
  List<UniversityActivity> activities = [];
  final DatabaseReference activitiesRef = FirebaseDatabase.instance.reference().child('university');
  late Uint8List tempImage ;
  bool imageLoaded = false;
  TextEditingController linkController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  void setPlaceHolder(Uint8List image) {
    tempImage = image;
    imageLoaded = true;
    notifyListeners();
  }
  void addLink(String image) {
    activities.add(UniversityActivity(image: image, about: aboutController.text, link: linkController.text));
    notifyListeners();
  }
  void deleteUniversityActivity(int index) {
    activities.removeAt(index);
    activitiesRef.remove();
    for(int i = 0; i < activities.length; i++) {
      activitiesRef.push().set(activities[i].toJson());
    }
    notifyListeners();
  }
  void addToDatabase() {
    activitiesRef.push().set(activities.last.toJson());
  }
  Future<void> getFromDatabase() async {
    activities = [];
    Query query = activitiesRef;
    await query.once().then((value) {
      for (var element in value.snapshot.children) {
        activities.add(UniversityActivity.fromJson(element.value as Map));
      }
    });
  }
}