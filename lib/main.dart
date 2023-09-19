import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hertzrentacar/screens/splashscreen.dart';
import 'package:provider/provider.dart';

import 'Repositories/firebasemessaging.dart';
import 'Utils/providers.dart';
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("handling a background message ${message.notification!.title}");
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FCM().requestNotificationPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => ProviderClass(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hertz Rent a Car',
        theme: ThemeData(
            primarySwatch: Colors.yellow,
            brightness: Brightness.light),
        home: SplashScreen());
  }
}
