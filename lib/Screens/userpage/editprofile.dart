import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hertzrentacar/Repositories/sharedpref.dart';
import 'package:hertzrentacar/Utils/Widgets/elevatedbutton.dart';
import 'package:hertzrentacar/Utils/functions.dart';
import 'package:hertzrentacar/Utils/providers.dart';
import 'package:provider/provider.dart';

import '../../Repositories/userRepo.dart';
import '../../Utils/Widgets/bottomsheet.dart';
import '../../Utils/Widgets/textfield.dart';
import '../../Utils/Widgets/widgetsandvariables.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? username;
  String? userEmail;
  fetchUserProfile()async{
   await fetchUserData();

    Future.delayed(Duration(milliseconds:1000 )).then((value) {
      setState(() {
       print(userData["username"]);
       email.text=userData["email"];
       name.text=userData["username"];

      });
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ProviderClass>(context, listen: false).getProfilePhoto();
      fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderClass>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_outlined)),
        backgroundColor: Colors.white,
        title: Text(
          "Edit Profile",
          style: Variables.blacktextstyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              children: [
                provider.imagePath != null
                    ? Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                              scale: 2,
                              File(provider.imagePath!)))),
                )
                    : Image.asset(
                    width: 100, height: 100, "assets/prfile.png"),
                sizedbox,
                CustomElevatedButton(
                  text: "Add a Photo",
                  onPressed: () {
                    BottomSheet1().imagePickBottomSheet(context, true);
                  },
                ),
                sizedbox,
                TextFields(
                  controller: name,
                  hintText: "UserName",
                  // initialValue: userData["username"],
                  onChanged: (value) {
                    username = value;
                  },
                ),
                TextFields(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Email",
                  // initialValue: userData["email"],
                  onChanged: (value) {
                    userEmail = value;
                  },
                ),
                sizedbox,
                InkWell(
                  onTap: () {
                    updateUserData(username, userEmail);
                  },
                  child: Image(
                      width: 100,
                      height: 100,
                      image: AssetImage("assets/tickmark.png")),
                ),
                CustomElevatedButton(
                  text: "Log Out",
                  onPressed: () {
                    SharedPreferences1().userSignOut(context);
                  },
                ),
              ],
            )

        ),
      ),
    );
  }
}