
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hertzrentacar/Utils/providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import '../Screens/rentalownerpage/cardetailsupload.dart';

class Images{
  File? fileImg;

    final imagePicker=ImagePicker();
  var url;

  saveProfilePhoto(String value,BuildContext context) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('path', value);
    Provider.of<ProviderClass>(context,listen: false).getProfilePhoto();
  }

  pickProfilePhoto(BuildContext context,ImageSource source) async {
    XFile? image = await imagePicker.pickImage(
        source: source);
    if (image != null) {
      saveProfilePhoto(image.path.toString(),context);

    }
  }

   passImage(BuildContext context,ImageSource source) async {
    XFile? image = await imagePicker.pickImage(
        source: source);
    if (image != null) {
      fileImg = File(image.path);

      var ref = FirebaseStorage.instance.ref().child("image/${fileImg!.path}");
      await ref.putFile(fileImg!);

      url = await ref.getDownloadURL();

      print(url);
      if(url!=null){
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return CarDetailsUpload(
                showImage: url);
          }));
      }

    }
  }

}
