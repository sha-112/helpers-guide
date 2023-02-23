import 'package:flutter/material.dart';
import 'package:helperguide/controllers/edit_locations_provider.dart';
import 'package:helperguide/modules/event.dart';
import 'package:helperguide/modules/location.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class EditLocations extends StatelessWidget {
  const EditLocations({Key? key}) : super(key: key);

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
                  " Edit Locations",
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
                "  Locations Information",
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
                          height: 350,
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
                                  controller: context.watch<EditLocationsProvider>().nameController,
                                  cursorColor: Colors.black,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFFA1C3FC), width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    hintText: "Name",
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        letterSpacing: 0.5
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                  controller: context.watch<EditLocationsProvider>().detailsController,
                                  cursorColor: Colors.black,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFFA1C3FC), width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    hintText: "Details",
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        letterSpacing: 0.5
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                  controller: context.watch<EditLocationsProvider>().linkController,
                                  cursorColor: Colors.black,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFFA1C3FC), width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    hintText: "Google Maps Link",
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        letterSpacing: 0.5
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox.shrink()),
                              SizedBox(
                                width: 250,
                                child: TextButton(
                                  onPressed: () async {
                                    Provider.of<EditLocationsProvider>(newContext, listen: false).addLocation();
                                    Navigator.pop(newContext);
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Color(0xFF151A4F),)
                                  ),
                                  child: const Text(
                                    "Add new Location",
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
              itemCount: context.watch<EditLocationsProvider>().locations.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    LocationCard(location: context.watch<EditLocationsProvider>().locations[index], index: index,),
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

class LocationCard extends StatelessWidget {
  const LocationCard({Key? key, required this.location, required this.index}) : super(key: key);
  final Location location;
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
                      Provider.of<EditLocationsProvider>(context, listen: false).deleteLocations(index);
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
        onTap: () {
          launchUrl(Uri.parse(location.link));
        },
        contentPadding: EdgeInsets.zero,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.black,
              size: 40,
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 5,),
                  Text(
                    location.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    location.details,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
