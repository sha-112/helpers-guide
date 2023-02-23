import 'package:flutter/material.dart';

class Events {
  Events({required this.eventName, required this.eventDetails, required this.date, required this.startTime, required this.endTime});
  String eventName;
  String eventDetails;
  DateTime date;
  String startTime;
  String endTime;

  Events.fromJson(Map<dynamic, dynamic> json)
    : eventName = json['eventName'],
      eventDetails = json['eventDetails'],
      date = DateTime.parse(json['date']),
      startTime = json['startTime'],
      endTime = json['endTime'];

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'eventName': eventName,
    'eventDetails': eventDetails,
    'date': date.toString(),
    'startTime': startTime,
    'endTime': endTime,
  };
}