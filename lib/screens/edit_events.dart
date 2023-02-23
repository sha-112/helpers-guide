import 'dart:typed_data';

import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:helperguide/controllers/edit_events_provider.dart';
import 'package:helperguide/controllers/edit_university_provider.dart';
import 'package:helperguide/firebase/firebase_storage.dart';
import 'package:helperguide/modules/event.dart';
import 'package:helperguide/modules/university_activitiy.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modules/university_activitiy.dart';

class EditEvents extends StatelessWidget {
  const EditEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF428DFC),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            height: MediaQuery.of(context).size.height/5,
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Expanded(child: SizedBox.shrink()),
                Text(
                  " Edit Events",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Text(
                "  Events Information",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              const Expanded(child: SizedBox.shrink()),
              IconButton(
                splashRadius: 25,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.edit,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext newContext) {
                      return AlertDialog(
                        content: SizedBox(
                          height: 500,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  maxLines: 1,
                                  maxLength: 20,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                  controller: context.watch<EditEventsProvider>().nameController,
                                  cursorColor: Colors.black,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFFA1C3FC), width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    hintText: "Event Name",
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        letterSpacing: 0.5
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                  controller: context.watch<EditEventsProvider>().detailsController,
                                  cursorColor: Colors.black,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFFA1C3FC), width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    hintText: "Event Details",
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        letterSpacing: 0.5
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              const SizedBox(
                                width: double.maxFinite,
                                child: Text(
                                  "Date",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 5,),
                                  Text(
                                    newContext.watch<EditEventsProvider>().tempDate,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const Expanded(child: SizedBox.shrink()),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                    onPressed: () async {
                                      Provider.of<EditEventsProvider>(context, listen: false).setDate((await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 1)), lastDate: DateTime.now().add(const Duration(days: 365))))!);
                                    },
                                  ),
                                  const SizedBox(width: 5,),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              const SizedBox(
                                width: double.maxFinite,
                                child: Text(
                                  "Start Time",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 5,),
                                  Text(
                                    newContext.watch<EditEventsProvider>().startTime,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const Expanded(child: SizedBox.shrink()),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                    onPressed: () async {
                                      Provider.of<EditEventsProvider>(context, listen: false).setStartTime((await showTimePicker(context: context, initialTime: TimeOfDay.now()))!.format(newContext));
                                    },
                                  ),
                                  const SizedBox(width: 5,),                                ],
                              ),
                              const SizedBox(height: 10,),
                              const SizedBox(
                                width: double.maxFinite,
                                child: Text(
                                  "End Time",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 5,),
                                  Text(
                                    newContext.watch<EditEventsProvider>().endTime,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const Expanded(child: SizedBox.shrink()),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                    onPressed: () async {
                                      Provider.of<EditEventsProvider>(context, listen: false).setEndTime((await showTimePicker(context: context, initialTime: TimeOfDay.now()))!.format(newContext));
                                    },
                                  ),
                                  const SizedBox(width: 5,),                                ],
                              ),
                              const Expanded(child: SizedBox.shrink()),
                              SizedBox(
                                width: 250,
                                child: TextButton(
                                  onPressed: () async {
                                    Provider.of<EditEventsProvider>(newContext, listen: false).addEvent();
                                    Navigator.pop(newContext);
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Color(0xFF151A4F),)
                                  ),
                                  child: const Text(
                                    "Add new Event",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(width: 10,),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              itemCount: context.watch<EditEventsProvider>().events.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    EventCard(event: context.watch<EditEventsProvider>().events[index], index: index,),
                    const SizedBox(height: 5,),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({Key? key, required this.event, required this.index}) : super(key: key);
  final Events event;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(0xFFA1C3FC),
      ),
      child: ListTile(
        onLongPress: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: const Color(0xFF242424),
                shape: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF848484), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                content: const SizedBox(
                  width: 300,
                  child: Text(
                    'Do you want delete this event?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      Provider.of<EditEventsProvider>(context, listen: false).deleteEvents(index);
                      Navigator.pop(context);
                    },
                    child: const Text('Confirm'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        contentPadding: EdgeInsets.zero,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 5,),
            Text(
              event.eventName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              event.eventDetails,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.end,
            ),
            const SizedBox(height: 10,),
            Text(
              "${event.startTime} - ${event.endTime}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }
}
