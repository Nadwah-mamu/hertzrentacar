import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hertzrentacar/Repositories/sharedpref.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image(
              fit: BoxFit.fill, image: AssetImage("assets/Dodge Charger.jpeg")),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                SharedPreferences1().signIn(context, true,true);
              },
              child: Container(
                height: 70,
                width: 330,
                margin: EdgeInsets.only(left: 30, bottom: 25),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(15, 82, 186, 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Join As Car Rental Owner",
                    style: GoogleFonts.notoSans(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                SharedPreferences1().signIn(context, false,false);
              },
              child: Container(
                height: 70,
                width: 330,
                margin: EdgeInsets.only(left: 30, bottom: 25),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(15, 82, 186, 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Join As Hertz Customer",
                    style: GoogleFonts.notoSans(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
