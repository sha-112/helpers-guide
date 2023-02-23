// import 'dart:typed_data';
//
// import 'package:file_picker_cross/file_picker_cross.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:helperguide/controllers/edit_locations_provider.dart';
// import 'package:helperguide/controllers/edit_profile_provider.dart';
// import 'package:helperguide/firebase/firebase_storage.dart';
// import 'package:helperguide/modules/event.dart';
// import 'package:helperguide/modules/location.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
//
// class EditProfile extends StatelessWidget {
//   const EditProfile({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = Provider.of<User?>(context);
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: const BoxDecoration(
//               color: Color(0xFF428DFC),
//               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
//             ),
//             height: MediaQuery.of(context).size.height/6,
//             width: double.maxFinite,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: const [
//                 Expanded(child: SizedBox.shrink()),
//                 Text(
//                   " Edit Profile",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//               ],
//             ),
//           ),
//           const SizedBox(height: 10,),
//           const Text(
//             "  Profile Information",
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold
//             ),
//           ),
//           const SizedBox(height: 10,),
//           TextButton(
//             onPressed: () async {
//               FilePickerCross myFile = await FilePickerCross.importFromStorage();
//               Uint8List fileBytes = myFile.toUint8List();
//               String fileName = myFile.fileName!;
//               StorageManager sm = StorageManager();
//               String? location = await sm.uploadFile(fileName, fileBytes);
//               if(location != null) {
//                 print(location);
//                 await user.updatePhotoURL(location);
//                 await user.reload();
//                 Provider.of<EditProfileProvider>(context, listen: false).updateImage(user);
//               }
//             },
//             child: user!.photoURL == null ? CircleAvatar(
//               backgroundImage: AssetImage(context.watch<EditProfileProvider>().image),
//               radius: 50,
//             ) : CircleAvatar(
//               backgroundImage: NetworkImage(user.photoURL!),
//               radius: 50,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
//             child: Row(
//               children: [
//                 const SizedBox(
//                   width: 110,
//                   child: Text(
//                     "Full name: ",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     height: 40,
//                     child: TextFormField(
//                       maxLines: 1,
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 18.0,
//                       ),
//                       cursorColor: Colors.black,
//                       textAlignVertical: TextAlignVertical.center,
//                       controller: context.watch<EditProfileProvider>().fullName,
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xFFA1C3FC), width: 1.0),
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         hintText: "Full Name",
//                         hintStyle: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             letterSpacing: 0.5
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
//             child: Row(
//               children: [
//                 const SizedBox(
//                   width: 110,
//                   child: Text(
//                     "Email: ",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     height: 40,
//                     child: TextFormField(
//                       maxLines: 1,
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 18.0,
//                       ),
//                       cursorColor: Colors.black,
//                       textAlignVertical: TextAlignVertical.center,
//                       controller: context.watch<EditProfileProvider>().email,
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xFFA1C3FC), width: 1.0),
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         hintText: "Your Email",
//                         hintStyle: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             letterSpacing: 0.5
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
//             child: Row(
//               children: [
//                 const SizedBox(
//                   width: 110,
//                   child: Text(
//                     "Password: ",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     height: 40,
//                     child: TextFormField(
//                       maxLines: 1,
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 18.0,
//                       ),
//                       cursorColor: Colors.black,
//                       textAlignVertical: TextAlignVertical.center,
//                       controller: context.watch<EditProfileProvider>().password,
//                       obscureText: true,
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xFFA1C3FC), width: 1.0),
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         hintText: "Password",
//                         hintStyle: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             letterSpacing: 0.5
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Expanded(child: SizedBox.shrink()),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
//             child: SizedBox(
//               width: 250,
//               child: TextButton(
//                 onPressed: () async {
//                   Provider.of<EditProfileProvider>(context, listen: false).updateInfo(user);
//                 },
//                 style: const ButtonStyle(
//                     backgroundColor: MaterialStatePropertyAll(Color(0xFF151A4F),)
//                 ),
//                 child: const Text(
//                   "Update",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10,),
//         ],
//       ),
//     );
//   }
// }
//
// class LocationCard extends StatelessWidget {
//   const LocationCard({Key? key, required this.location, required this.index}) : super(key: key);
//   final Location location;
//   final int index;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         color: Color(0xFFA1C3FC),
//       ),
//       child: ListTile(
//         onLongPress: () async {
//           await showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 backgroundColor: const Color(0xFF242424),
//                 shape: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xFF848484), width: 1.0),
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//                 content: const SizedBox(
//                   width: 300,
//                   child: Text(
//                     'Do you want delete this event?',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 actions: [
//                   ElevatedButton(
//                     onPressed: () async {
//                       Provider.of<EditLocationsProvider>(context, listen: false).deleteLocations(index);
//                       Navigator.pop(context);
//                     },
//                     child: const Text('Confirm'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text('Cancel'),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//         onTap: () {
//           launchUrl(Uri.parse(location.link));
//         },
//         contentPadding: EdgeInsets.zero,
//         title: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.location_on_outlined,
//               color: Colors.black,
//               size: 40,
//             ),
//             const SizedBox(width: 10,),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const SizedBox(height: 5,),
//                   Text(
//                     location.name,
//                     style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold
//                     ),
//                   ),
//                   const SizedBox(height: 5,),
//                   Text(
//                     location.details,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                     ),
//                   ),
//                   const SizedBox(height: 5,),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
