import 'package:flutter/material.dart';
import 'package:hertzrentacar/Repositories/rentalownerrepo.dart';
import 'package:hertzrentacar/Screens/rentalownerpage/homepage.dart';
import 'package:hertzrentacar/Screens/userpage/homepage1.dart';
import 'package:provider/provider.dart';

import '../Repositories/userRepo.dart';
import '../Utils/Widgets/widgetsandvariables.dart';
import '../Utils/functions.dart';
import '../Utils/providers.dart';

class SignupForm extends StatelessWidget {
  var carowner;
  SignupForm({required this.carowner});

  final formkey = GlobalKey<FormState>();
  late String companyName;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderClass>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                provider.isSignUp == true
                    ? Text("Sign Up", style: Variables.bluetextstyle)
                    : Text("Sign In", style: Variables.bluetextstyle),
                provider.isSignUp == true
                    ? TextFormField(
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        controller: name,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Name is a required field";
                          }
                        },

                        decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 20),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: carowner == true
                                ? "Company name"
                                : "User Name"),
                      )
                    : SizedBox(),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  cursorHeight: 25,
                  // cursorRadius: Radius.circular(10),
                  controller: email,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Email is a required field";
                    }
                  },
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "Email"),
                ),
                TextFormField(
                  obscureText: provider.isobscured,
                  cursorColor: Colors.black,
                  cursorHeight: 25,
                  controller: password,
                  validator: (v) {
                    v!.isEmpty ?
                       "enter password": null;

                  },
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            Provider.of<ProviderClass>(context, listen: false)
                                .passwordIcon();
                          },
                          child: provider.isobscured
                              ? Icon(
                                  Icons.visibility_off,
                                  color: Colors.black45,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                )),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "Password"),
                ),
                provider.isSignUp == true
                    ? TextFormField(
                        controller: mobno,
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Mobile number is a required field";
                          }
                        },
                        decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 20),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "Mobile Number"),
                      )
                    : SizedBox(),
                InkWell(
                  onTap: () async {
                    bool a = false;
                    final formfill = formkey.currentState!.validate();
                    if (formfill == true) {
                      provider.isSignUp == true
                          ? a = await signUp(email:email.text,password:password.text,username: name.text)
                          : a = await login(email: email.text ,password: password.text);
                      if (a == true) {
                        if (carowner==true) {
                          provider.isSignUp == true
                              ? Rental().passRentalownerDetails(companyName: companyName)
                              : null;

                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }), (route) => false);
                        } else {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage1();
                          }), (route) => false);
                        }
                      }
                    }
                    email.clear();
                    password.clear();
                    name.clear();
                    mobno.clear();
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    margin: EdgeInsets.only(top: 25),
                    child: Center(
                      child: provider.isSignUp == true
                          ? Text("Sign Up", style: Variables.whitetextstyle)
                          : Text("Sign In", style: Variables.whitetextstyle),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(thickness: 2),
                provider.isSignUp == true
                    ? Text(
                        "Already an existing account with Hertz ?",
                        style: TextStyle(fontSize: 18),
                      )
                    : Text(
                        "Create an account with Hertz",
                        style: TextStyle(fontSize: 18),
                      ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      Provider.of<ProviderClass>(context, listen: false)
                          .updateWidget();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        provider.isSignUp == true
                            ? Text("Login here",
                                style: Variables.blacktextstyle)
                            : Text("SignUp here",
                                style: Variables.blacktextstyle),
                        Icon(Icons.login_outlined)
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
