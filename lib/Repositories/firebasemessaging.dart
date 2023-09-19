import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hertzrentacar/Utils/Widgets/widgetsandvariables.dart';
import 'package:http/http.dart' as http;

import '../Screens/rentalownerpage/vieworders.dart';
import '../Screens/userpage/ratingbar1.dart';



String serverKey =
    "AAAAickZLmw:APA91bGuQhR5OWZIj_9VVpfn7mxM7cpKXZgi2ZS-JWrwUwJNYNjHNVFBdalRk5Wl0Z_u4j2o-0Nsv-ylvslgTnRayQokjrczBGFYeh1ZhSFCrtPGeH1TA7UjncUu8dpdmwhjstB_tTEK";

class FCM{
  DocumentSnapshot? documentSnapshot;
  FCM({this.documentSnapshot});

  late AndroidNotificationChannel channel;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  FirebaseMessaging firebaseMessaging=FirebaseMessaging.instance;

  final url = 'https://fcm.googleapis.com/fcm/send';

  final headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Authorization': 'key=$serverKey',
  };


  void requestNotificationPermission() async {
    NotificationSettings notificationSettings =
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }
  }


  void loadFCM(BuildContext context, RemoteMessage message) async {
    var androidInitializationSetting =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSetting =
    InitializationSettings(android: androidInitializationSetting);

    flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(context,message);
        });
  }


  void handleMessage(BuildContext context ,RemoteMessage message) {
    if (message.data["pageToOpen"] == 'viewOrder') {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ViewOrders(documentSnapshot: documentSnapshot,)), (route) => false);}
    if (message.data["pageToOpen"] == 'OrderConfirm') {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RatingScreen1()), (route) => false);}

  }

  void listenFCM(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("notification :${message.notification!.title.toString()}");

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      loadFCM(context,message);

      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.max,
      );

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title.toString(),
          notification.body.toString(),
          NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: "your channel description",
                importance: Importance.high,
                priority: Priority.high,
                ticker: "ticker",
                color: Variables.bluecolor
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }

  void sendNotification(String Token) async {


    try {

      final body = {
        'priority': 'high',
        'data': {'pageToOpen': 'viewOrder'},
        'to': Token.toString(),
        'notification': {
          'title': "You've got an Order",
          'body': documentSnapshot!["carNameAndModel"],
        },
      };
        final response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        if (response.statusCode == 200) {
          print('Notification sent successfully');
        } else {
          print('Failed to send notification');
        }





    } catch (e) {
      String error = e.toString();
      print("error is $error");
    }
  }

  void sendNotificationToUser(String Token,bool hello) async {

    try {
      final body = {
        'priority': 'high',
        'data': {'pageToOpen': 'OrderConfirm'},
        'to': Token.toString(),
        'notification': {
          'title': hello==true ?"YOUR ORDER IS CONFIRMED":"YOUR ORDER IS REJECTED",
              'body':'!!'

        },
      };
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification');
      }





    } catch (e) {
      String error = e.toString();
      print("error is $error");
    }
  }




}