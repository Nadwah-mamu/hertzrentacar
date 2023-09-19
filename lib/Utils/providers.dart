
import 'package:flutter/material.dart';
import 'package:hertzrentacar/Repositories/userRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProviderClass extends ChangeNotifier {
  int selectedIndex = 0;
  void updateSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  bool isobscured = true;
  void passwordIcon() {
    isobscured = !isobscured;
    notifyListeners();
  }

  bool isSignUp = true;
  void updateWidget() {
    isSignUp = !isSignUp;
    notifyListeners();
  }

  Stream stream =
      fireStore.collection("cardetails").snapshots();
  void streamChange({required Stream stream1}) {
    stream = stream1;
    notifyListeners();
  }

  void stream1Change({required Stream stream2}) {
    stream = stream2;
    notifyListeners();
  }

  void stream2Change({required Stream stream3}) {
    stream = stream3;
    notifyListeners();
  }


  String? imagePath;
  void getProfilePhoto() async {
    final sharedPref = await SharedPreferences.getInstance();
      imagePath = sharedPref.getString('path');
      notifyListeners();
  }


}
