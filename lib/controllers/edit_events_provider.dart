import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../modules/event.dart';


class EditEventsProvider extends ChangeNotifier{
  List<Events> events = [];
  final DatabaseReference eventsRef = FirebaseDatabase.instance.reference().child('events');
  late Uint8List tempImage ;
  bool imageLoaded = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  String startTime = "00:00";
  String endTime = "00:00";
  String tempDate = DateTime.now().toString().substring(0,10);
  DateTime date = DateTime.now();

  void deleteEvents(int index) async {
    events.removeAt(index);
    eventsRef.remove();
    for(int i = 0; i < events.length; i++) {
      await eventsRef.push().set(events[i].toJson());
    }
    notifyListeners();
  }
  void addToDatabase(Events event) async {
    events.add(event);
    await eventsRef.push().set(event.toJson());
  }
  Future<void> getFromDatabase() async {
    events = [];
    Query query = eventsRef;
    await query.once().then((value) {
      for (var element in value.snapshot.children) {
        events.add(Events.fromJson(element.value as Map));
      }
    });
  }
  void setDate(DateTime value) {
    date = value;
    notifyListeners();
  }
  void setStartTime(String value) {
    startTime = value;
    notifyListeners();
  }
  void setEndTime(String value) {
    endTime = value;
    notifyListeners();
  }
  void addEvent() {
    tempDate = date.toString().substring(0,10);
    print("fffffffffffff");
    print(events.length);
    addToDatabase(Events(eventName: nameController.text, eventDetails: detailsController.text, date: date, startTime: startTime, endTime: endTime));
    print(events.length);
    notifyListeners();
  }
  bool getEvents(int index, DateTime current) {
    return (events[index].date.year ==  current.year && events[index].date.month ==  current.month && events[index].date.day ==  current.day);
  }
}