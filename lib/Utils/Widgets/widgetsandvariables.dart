import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
final sizedbox = SizedBox(
  height: 20,
);


class Variables {
   String brands='';

  static final rupeeicon=            Icon(
    Icons.currency_rupee,
    size: 25,
    color: Colors.black,
  );

      static final moneyicon=        Icon(
    Icons.money_outlined,
    color: Variables.bluecolor,
    size: 33,
  );

      static final fuelicon=        Icon(
    Icons.local_gas_station_sharp,
    color: Variables.bluecolor,
    size: 33,
  );

      static final speedicon=        Icon(
  Icons.speed_sharp,
  color: Variables.bluecolor,
  size: 33,
  );

  static final capacityicon=Icon(
  Icons.reduce_capacity_outlined,
  color: Variables.bluecolor,
  size: 33,
  );

  static final sizebox = SizedBox(
    height: 8,
  );
  static final textStyle = TextStyle(fontSize: 20, color: Colors.black45);
  static final bluecolor = Color.fromRGBO(15, 82, 186, 3);

  static final buttoncolor =
      ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(bluecolor));
  static final bluetextstyle = GoogleFonts.notoSans(
      fontSize: 22, color: bluecolor, fontWeight: FontWeight.bold);

  static final whitetextstyle = TextStyle(fontSize: 20, color: Colors.white);

  static const blacktextstyle =  TextStyle(
      fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);

  static final inputdecoration = InputDecoration(
      hintStyle: TextStyle(fontSize: 20),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      hintText: "User Name");

//  Container widget

  static final boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
          colors: [Colors.lightBlue.shade50, Colors.lightBlue.shade200]));
  static final padding = EdgeInsets.only(top: 10, left: 10);
  static final margin = EdgeInsets.only(top: 12, left: 10, right: 10);
}

