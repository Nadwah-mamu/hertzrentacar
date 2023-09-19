import 'package:flutter/material.dart';
import 'package:hertzrentacar/Repositories/sharedpref.dart';
import 'package:hertzrentacar/Screens/rentalownerpage/rating&review.dart';


class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  final sizedbox = SizedBox(
    height: 10,
  );
  final textstyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              subtitle:
                  Text("nadwanadz22@gmail.com", style: TextStyle(fontSize: 18)),
              title: Text("Nadwah Mamu", style: textstyle),
              leading: OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  )),
            ),
            Divider(
              thickness: 2,
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return RatingScreen();
                }));
              },
              child: ListTile(
                leading: Icon(
                  Icons.star_border_rounded,
                  size: 30,
                ),
                title: Text(
                  "Ratings and Reviews",
                  style: textstyle,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 30,
              ),
              title: Text(
                "View Orders",
                style: textstyle,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.label,
                size: 30,
              ),
              title: Text(
                "Terms and Conditions",
                style: textstyle,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                size: 30,
              ),
              title: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            content: Text(
                              "Do you want to exit",
                            ),
                            title: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    SharedPreferences1().userSignOut(context);
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)))
                            ],
                          );
                        });
                  },
                  child: Text(
                    "Log Out",
                    style: textstyle,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
