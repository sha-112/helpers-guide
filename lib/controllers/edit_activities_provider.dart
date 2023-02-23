import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:helperguide/modules/activitiy.dart';

class EditActivitiesProvider extends ChangeNotifier{
  List<Activity> activities = [];
  final DatabaseReference activitiesRef = FirebaseDatabase.instance.reference().child('activities');
  late Uint8List tempImage ;
  bool imageLoaded = false;
  TextEditingController linkController = TextEditingController();

  void setPlaceHolder(Uint8List image) {
    tempImage = image;
    imageLoaded = true;
    notifyListeners();
  }
  void setImage(String image) {
    // activitiesRef.limitToFirst(5);
    activities.add(Activity(image: image, link: ""));
  }
  void addLink(String image) {
    activities.add(Activity(image: image, link: linkController.text));
    notifyListeners();
  }
  void deleteActivity(int index) {
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
        activities.add(Activity.fromJson(element.value as Map));
      }
    });
  }
}