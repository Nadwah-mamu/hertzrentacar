import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hertzrentacar/Repositories/userRepo.dart';
import 'package:hertzrentacar/Utils/Widgets/widgetsandvariables.dart';

import '../Screens/rentalownerpage/homepage.dart';
import '../Utils/functions.dart';
import 'firebasemessaging.dart';

var showImage;

class Rental {
  Map<String, dynamic> carDetails = {
    "companyName": companyName.text,
    "carNameAndModel": carNameandModel.text,
    "carPrice": carPrices,
    "carCapacity": carNo.text,
    "maxSpeed": engineType.text,
    "fuelType": fuelType.text
  };

  saveCarDetails(BuildContext context, var showImage,
      GlobalKey<FormState> formKey) async {
    carDetails["carImage"] = showImage;
    final formFill = formKey.currentState?.validate();
    if (formFill == true) {
      //passing car details to fireStore
      await fireStore.collection("cardetails").add(carDetails);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
            return HomePage();
          }), (route) => false);
    }
  }

  passRentalownerDetails({required String companyName}) async {
    await fireStore.collection("rentalowners").add({
      "company name": name.text,
      "email": email.text,
      "password": password.text
    });
  }

  updateCarDetails(BuildContext context,
      DocumentSnapshot documentSnapshot) async {
    await fireStore
        .collection("cardetails")
        .doc(documentSnapshot.id)
        .update(carDetails);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return HomePage();
    }), (route) => false);
  }

  notifAccept(BuildContext context) async {
    FCM().listenFCM(context);
    String? token = await FCM().firebaseMessaging.getToken();
    if (token != null) {
      FCM().sendNotificationToUser(token, true);
    }
  }

  notifReject(BuildContext context) async {
    FCM().listenFCM(context);
    String? token = await FCM().firebaseMessaging.getToken();
    if (token != null) {
      FCM().sendNotificationToUser(token, false);
    }
  }

  deleteCarDetails(BuildContext context,
      DocumentSnapshot documentSnapshot) async {
    await fireStore
        .collection("cardetails")
        .doc(documentSnapshot.id)
        .delete();
  }
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircularProgressIndicator(
//                   color: Variables.bluecolor,
//                 ),
//                 SizedBox(width: 10,),
//                 Text("Deleting")
//               ],
//             ),
//           );
//         });
//
// Timer(Duration(seconds: 2), () {Navigator.pop(context); });}}
}