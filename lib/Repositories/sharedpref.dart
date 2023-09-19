import 'package:flutter/material.dart';
import 'package:hertzrentacar/Repositories/userRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/firstpage.dart';
import '../Screens/rentalownerpage/homepage.dart';
import '../Screens/signup&login.dart';
import '../Screens/userpage/homepage1.dart';

Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
int second = 4;

class SharedPreferences1 {
   userSignOut(BuildContext context) {
    sharedPreferences.then((value) {
      value.getBool("rentalowner");
      value.clear();
      signOut();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return FirstPage();
      }), (route) => false);
    });
  }

  void signIn(BuildContext context, bool ok, bool rentalOwner) {
    sharedPreferences.then((value) {
      value.setBool("rentalowner", ok);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SignupForm(carowner: rentalOwner);
      }));
    });
  }

  void setSharedPref(BuildContext context) {
    Future.delayed(Duration(seconds: second)).then((value) {
      sharedPreferences.then((value) {
        var textValue = value.getBool("rentalowner");
        if (textValue == true) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return HomePage();
          }), (route) => false);
        } else if (textValue == false) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return HomePage1();
          }), (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return FirstPage();
          }), (route) => false);
        }
      });
    });
  }
}
