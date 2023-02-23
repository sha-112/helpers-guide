import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../modules/location.dart';


class EditLocationsProvider extends ChangeNotifier{
  List<Location> locations = [];
  final DatabaseReference locationsRef = FirebaseDatabase.instance.reference().child('locations');
  late Uint8List tempImage ;
  bool imageLoaded = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  void deleteLocations(int index) async {
    locations.removeAt(index);
    locationsRef.remove();
    for(int i = 0; i < locations.length; i++) {
      await locationsRef.push().set(locations[i].toJson());
    }
    notifyListeners();
  }
  void addToDatabase(Location location) async {
    locations.add(location);
    await locationsRef.push().set(location.toJson());
  }
  Future<void> getFromDatabase() async {
    locations = [];
    Query query = locationsRef;
    await query.once().then((value) {
      for (var element in value.snapshot.children) {
        locations.add(Location.fromJson(element.value as Map));
      }
    });
  }
  void addLocation() {
    addToDatabase(Location(name: nameController.text, details: detailsController.text, link: linkController.text));
    notifyListeners();
  }
  // bool getlocations(int index, DateTime current) {
  //   return (locations[index].date.year ==  current.year && locations[index].date.month ==  current.month && locations[index].date.day ==  current.day);
  // }
}