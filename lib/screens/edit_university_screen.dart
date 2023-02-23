import 'dart:typed_data';

import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:helperguide/controllers/edit_university_provider.dart';
import 'package:helperguide/firebase/firebase_storage.dart';
import 'package:helperguide/modules/university_activitiy.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modules/university_activitiy.dart';

class EditUniversity extends StatelessWidget {
  const EditUniversity({Key? key}) : super(key: key);

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
                  " Edit University Information",
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
                " University Information",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              const Expanded(child: SizedBox.shrink()),
              context.watch<EditUniversityProvider>().activities.length < 4 ? IconButton(
                splashRadius: 25,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.edit,
                ),
                onPressed: () {
                  String image = " ";
                  Uint8List fileBytes = Uint8List.fromList([]);
                  String fileName = " ";
                  Provider.of<EditUniversityProvider>(context, listen: false).imageLoaded = false;
                  showDialog(
                    context: context,
                    builder: (BuildContext newContext) {
                      return AlertDialog(
                        content: SizedBox(
                          height: 450,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
                                width: 300,
                                child: IconButton(
                                  icon: !newContext.watch<EditUniversityProvider>().imageLoaded ? Image.asset(
                                    "assets/placeholder.png",
                                    fit: BoxFit.fill,
                                    height: 200,
                                  ) : Image.memory(
                                    newContext.watch<EditUniversityProvider>().tempImage,
                                    fit: BoxFit.fill,
                                    height: 200,
                                  ),
                                  onPressed: () async {
                                    FilePickerCross myFile = await FilePickerCross.importFromStorage();
                                    fileBytes = myFile.toUint8List();
                                    fileName = myFile.fileName!;
                                    Provider.of<EditUniversityProvider>(newContext, listen: false).setPlaceHolder(fileBytes);
                                  },
                                ),
                              ),
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
                                  controller: context.watch<EditUniversityProvider>().aboutController,
                                  cursorColor: Colors.black,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFFA1C3FC), width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    hintText: "about",
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
                                  controller: context.watch<EditUniversityProvider>().linkController,
                                  cursorColor: Colors.black,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFFA1C3FC), width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    hintText: "Link",
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
                                    if(Provider.of<EditUniversityProvider>(context, listen: false).imageLoaded){
                                      Navigator.pop(context);
                                    }
                                    StorageManager sm = StorageManager();
                                    String? location = await sm.uploadFile(fileName, fileBytes);
                                    print("location");
                                    if(location != null) {
                                      print(location);
                                      image = location;
                                      Provider.of<EditUniversityProvider>(context, listen: false).addLink(image);
                                      Provider.of<EditUniversityProvider>(context, listen: false).addToDatabase();
                                    }
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Color(0xFF151A4F),)
                                  ),
                                  child: const Text(
                                    "Add new Information",
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
              ) : const SizedBox.shrink(),
              const SizedBox(width: 10,),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: context.watch<EditUniversityProvider>().activities.length,
              itemBuilder: (BuildContext context, int index) {
                return UniversityActivityCard(universityActivity: Provider.of<EditUniversityProvider>(context, listen: false).activities[index], index: index,);
              },
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}

class UniversityActivityCard extends StatelessWidget {
  const UniversityActivityCard({Key? key, required this.universityActivity, required this.index}) : super(key: key);
  final UniversityActivity universityActivity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextButton(
        onPressed: () {
          launchUrl(Uri.parse(universityActivity.link));
        },
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
                      Provider.of<EditUniversityProvider>(context, listen: false).deleteUniversityActivity(index);
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              universityActivity.image,
              fit: BoxFit.fitWidth,
              height: 200,
              color: Colors.blueGrey,
              colorBlendMode: BlendMode.dst,
            ),
            Text(
              universityActivity.about,
              style: TextStyle(
                fontSize: 15,
                background: Paint()
                  ..color = Colors.white54,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = Colors.black,
              ),
            )
          ],
        )
      ),
    );
  }
}
