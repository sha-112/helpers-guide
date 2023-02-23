import 'dart:typed_data';

import 'package:card_swiper/card_swiper.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helperguide/controllers/edit_activities_provider.dart';
import 'package:helperguide/controllers/edit_events_provider.dart';
import 'package:helperguide/controllers/edit_locations_provider.dart';
import 'package:helperguide/controllers/home_screen_provider.dart';
import 'package:helperguide/firebase/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/edit_profile_provider.dart';
import '../controllers/edit_university_provider.dart';
import '../firebase/firebase_storage.dart';
import '../modules/event.dart';
import '../modules/location.dart';
import '../modules/university_activitiy.dart';
import 'edit_events.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          color: const Color(0xFF428DFC),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: TextButton(
                  child: Column(
                    children: [
                      Icon(
                        Icons.home,
                        color: context.watch<HomeScreenProvider>().currentPage == 0 ? Colors.black : Colors.white,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          color: context.watch<HomeScreenProvider>().currentPage == 0 ? Colors.black : Colors.white,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    Provider.of<HomeScreenProvider>(context, listen: false).jumpToPage(0, user);
                  },
                )
              ),
              Expanded(
                child: TextButton(
                  child: Column(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: context.watch<HomeScreenProvider>().currentPage == 1 ? Colors.black : Colors.white,
                      ),
                      Text(
                        'Calender',
                        style: TextStyle(
                          color: context.watch<HomeScreenProvider>().currentPage == 1 ? Colors.black : Colors.white,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    Provider.of<HomeScreenProvider>(context, listen: false).jumpToPage(1, user);
                  },
                )
              ),
              Expanded(
                child: TextButton(
                  child: Column(
                    children: [
                      Icon(
                        Icons.map,
                        color: context.watch<HomeScreenProvider>().currentPage == 2 ? Colors.black : Colors.white,
                      ),
                      Text(
                        'Map',
                        style: TextStyle(
                          color: context.watch<HomeScreenProvider>().currentPage == 2 ? Colors.black : Colors.white,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    Provider.of<HomeScreenProvider>(context, listen: false).jumpToPage(2, user);
                  },
                )
              ),
              Expanded(
                child: TextButton(
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: context.watch<HomeScreenProvider>().currentPage == 3 ? Colors.black : Colors.white,
                      ),
                      Text(
                        'Account',
                        style: TextStyle(
                          color: context.watch<HomeScreenProvider>().currentPage == 3 ? Colors.black : Colors.white,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    Provider.of<HomeScreenProvider>(context, listen: false).jumpToPage(3, user);
                  },
                )
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: context.watch<HomeScreenProvider>().controller,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF428DFC),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                height: MediaQuery.of(context).size.height/4.5,
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    Text(
                      " Hi ${user!.displayName == null ? "${user!.displayName}": ""} !",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          " Hafr Al-Batin University",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      const Text(
                        "Activities around you",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const Expanded(child: SizedBox.shrink()),
                      user!.email!.contains("helper.com") ? IconButton(
                        splashRadius: 25,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/editActivities");
                        },
                      ) : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: FutureBuilder(
                  future: Provider.of<EditActivitiesProvider>(context, listen: false).getFromDatabase(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      return context.watch<EditActivitiesProvider>().activities.isNotEmpty ? const CardSwipe() : Container(height: 200,);
                    }
                    else {
                      return const SizedBox(height: 200,);
                    }
                  },
                ),
                // child: ,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SizedBox(
                  height: 25,
                  child: Row(
                    children: [
                      const Text(
                        "University Information",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const Expanded(child: SizedBox.shrink()),
                      user.email!.contains("helper.com") ? IconButton(
                        splashRadius: 25,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/editUniversity");
                        },
                      ) : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              const Expanded(child: UniversityInformation()),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF428DFC),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                height: MediaQuery.of(context).size.height/4,
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          context.watch<HomeScreenProvider>().months[context.watch<HomeScreenProvider>().current.month],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            DateTime? temp = await showDatePicker(
                              context: context,
                              initialDate: Provider.of<HomeScreenProvider>(context, listen: false).current,
                              firstDate: DateTime.now().subtract(const Duration(days: 365)),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            Provider.of<HomeScreenProvider>(context, listen: false).setCurrentDate(temp!);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        itemExtent: 65,
                        controller: context.watch<HomeScreenProvider>().scrollController,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: Provider.of<HomeScreenProvider>(context, listen: false).getNumberOfDays(),
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              FloatingActionButton(
                                shape: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(200)
                                ),
                                backgroundColor: context.watch<HomeScreenProvider>().current.day == index + 1 ? Colors.red : Colors.white,
                                onPressed: () {
                                  Provider.of<HomeScreenProvider>(context, listen: false).changeDate(index+1);
                                },
                                child: Text(
                                  (index+1).toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5,)
                            ],
                          );
                        },

                      ),

                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      Text(
                        "Events of ${context.watch<HomeScreenProvider>().current.day} ${context.watch<HomeScreenProvider>().months[context.watch<HomeScreenProvider>().current.month]}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const Expanded(child: SizedBox.shrink()),
                      user.email!.contains("helper.com") ? IconButton(
                        splashRadius: 25,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/editEvents");
                        },
                      ) : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: FutureBuilder(
                    future: Provider.of<EditEventsProvider>(context, listen: false).getFromDatabase(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: context.watch<EditEventsProvider>().events.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Provider.of<EditEventsProvider>(context, listen: false).getEvents(index, context.watch<HomeScreenProvider>().current) ? EventCard(event: context.watch<EditEventsProvider>().events[index], index: index,) : const SizedBox.shrink(),
                            );
                          },
                        );
                      }
                      else {
                        return const SizedBox(height: 200,);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF428DFC),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                height: MediaQuery.of(context).size.height/4.5,
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Expanded(child: SizedBox.shrink()),
                    Text(
                      " Hafr Al-Batin University",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40,),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      user.email!.contains("helper.com") ? IconButton(
                        splashRadius: 25,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/editLocations");
                        },
                      ) : const SizedBox.shrink(),
                      const Expanded(child: SizedBox.shrink()),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: const BoxDecoration(
                          color: Color(0xFFA1C3FC),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Text(
                          "مرافق مجمع الياسمين",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: FutureBuilder(
                    future: Provider.of<EditLocationsProvider>(context, listen: false).getFromDatabase(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: context.watch<EditLocationsProvider>().locations.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                LocationCard(location: context.watch<EditLocationsProvider>().locations[index], index: index,),
                                const SizedBox(height: 5,),
                              ],
                            );
                          },
                        );
                      }
                      else {
                        return const SizedBox(height: 200,);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF428DFC),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                height: MediaQuery.of(context).size.height/3,
                width: double.maxFinite,
                child: Column(
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    TextButton(
                      onPressed: () async {
                        FilePickerCross myFile = await FilePickerCross.importFromStorage();
                        Uint8List fileBytes = myFile.toUint8List();
                        String fileName = myFile.fileName!;
                        StorageManager sm = StorageManager();
                        String? location = await sm.uploadFile(fileName, fileBytes);
                        if(location != null) {
                          print(location);
                          await user.updatePhotoURL(location);
                          await user.reload();
                          Provider.of<EditProfileProvider>(context, listen: false).updateImage(user);
                          Provider.of<HomeScreenProvider>(context, listen: false).jumpToPage(3, user);
                        }
                      },
                      child: user.photoURL == null ? const CircleAvatar(
                        backgroundImage: AssetImage("assets/placeholder.png"),
                        radius: 50,
                      ) : CircleAvatar(
                        backgroundImage: NetworkImage(context.watch<EditProfileProvider>().url == " " ? user.photoURL! : context.watch<EditProfileProvider>().url),
                        radius: 50,
                      ),
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(140, 20)),
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                      ),
                      onPressed: () async {
                        FilePickerCross myFile = await FilePickerCross.importFromStorage();
                        Uint8List fileBytes = myFile.toUint8List();
                        String fileName = myFile.fileName!;
                        StorageManager sm = StorageManager();
                        String? location = await sm.uploadFile(fileName, fileBytes);
                        if(location != null) {
                          print(location);
                          await user.updatePhotoURL(location);
                          Provider.of<EditProfileProvider>(context, listen: false).updateImage(user);
                        }
                      },
                      child: const Text(
                        "Update Profile Pic",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 110,
                      child: Text(
                        "Full name: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        user.displayName != null ? user.displayName! : " ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 110,
                      child: Text(
                        "Email: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        user.email ??  " ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 110,
                      child: Text(
                        "Role: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        user.email!.contains("@helper.com") ? "Admin" : user.email!.contains("@uhb.edu.sa") ? "User": "Visitor",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox.shrink()),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SizedBox(
                  width: 250,
                  child: TextButton(
                    onPressed: () async {
                      AuthService().signOut();
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(0xFF151A4F),)
                    ),
                    child: const Text(
                      "Sign Out",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
            ],
          ),
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                universityActivity.image,
                fit: BoxFit.fill,
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

class UniversityInformation extends StatelessWidget {
  const UniversityInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<EditUniversityProvider>(context, listen: false).getFromDatabase(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                context.watch<EditUniversityProvider>().activities.isNotEmpty ? Expanded(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: UniversityActivityCard(universityActivity: context.watch<EditUniversityProvider>().activities[0], index: 0),
                            ),
                            context.watch<EditUniversityProvider>().activities.length > 1 ? Expanded(
                              child: UniversityActivityCard(universityActivity: context.watch<EditUniversityProvider>().activities[1], index: 1),
                            ) : const SizedBox.shrink(),
                          ],
                        ),
                      )
                  ),
                ) : const SizedBox.shrink(),
                context.watch<EditUniversityProvider>().activities.length > 2 ? Expanded(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: UniversityActivityCard(universityActivity: context.watch<EditUniversityProvider>().activities[2], index: 2),
                            ),
                            context.watch<EditUniversityProvider>().activities.length > 3 ? Expanded(
                              child: UniversityActivityCard(universityActivity: context.watch<EditUniversityProvider>().activities[3], index: 3),
                            ) : const SizedBox.shrink(),
                          ],
                        ),
                      )
                  ),
                ) : const SizedBox.shrink(),
              ],
            ),
          );
        }
        else {
          return const SizedBox(height: 200,);
        }
      },
    );
  }
}

class CardSwipe extends StatelessWidget {
  const CardSwipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
      ),
      height: 200,
      child: Swiper.children(
        indicatorLayout: PageIndicatorLayout.COLOR,
        autoplay: true,
        pagination: const SwiperPagination(),
        children: Provider.of<EditActivitiesProvider>(context, listen: false).activities.map((e) {
          return TextButton(
            onPressed: () {
              launchUrl(Uri.parse(e.link));
            },
            child: Image.network(
              e.image,
              fit: BoxFit.fill,
            ),
          );
        }).toList(),
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