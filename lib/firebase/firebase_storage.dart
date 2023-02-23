import 'dart:typed_data';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:helperguide/controllers/edit_activities_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class StorageManager
{
  Future<String?> uploadFile(String fileName, Uint8List fileBytes) async {
    print(await Permission.storage.request());
    print(await Permission.photos.request());
    print(await Permission.accessMediaLocation.request());
    print(await Permission.manageExternalStorage.request());
    String? location;

    // Upload file
    TaskSnapshot snapshot =  await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
    location = await snapshot.ref.getDownloadURL();
    //returns the download url
    return location;
  }
}