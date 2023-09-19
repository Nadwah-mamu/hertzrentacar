import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Repositories/firebasemessaging.dart';
import '../../Utils/Widgets/widgetsandvariables.dart';

class ViewVehicles extends StatelessWidget {
  DocumentSnapshot documentSnapshot;
  ViewVehicles({super.key, required this.documentSnapshot});

  final divider = Divider(
    thickness: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "CarDetails",
            style: Variables.blacktextstyle,
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_outlined)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              height: 150,
              width: 150,
              image: NetworkImage(documentSnapshot["carImage"]),
            ),
            divider,
            SizedBox(
              height: 15,
            ),
            ListTile(
              title: Text(
                documentSnapshot["carNameAndModel"],
                style: Variables.bluetextstyle,
              ),
              subtitle: Text("A car with high specs that are rented at an "
                  "affordable price"),
            ),
            divider,
            Text(
              "Specification",
              style: Variables.blacktextstyle,
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 130,
                width: 130,
                padding: Variables.padding,
                margin: Variables.margin,
                decoration: Variables.boxDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Variables.capacityicon,
                    Variables.sizebox,
                    Text("Capacity", style: Variables.textStyle),
                    Variables.sizebox,
                    Row(
                      children: [
                        Text(
                          documentSnapshot["carCapacity"].toString(),
                          style: Variables.blacktextstyle,
                        ),
                        Text(
                          "Seats",
                          style: Variables.blacktextstyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 130,
                width: 130,
                padding: Variables.padding,
                margin: Variables.margin,
                decoration: Variables.boxDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Variables.speedicon,
                    Variables.sizebox,
                    Text("MaxSpeed", style: Variables.textStyle),
                    Text(
                      "(km/h)",
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                    Variables.sizebox,
                    Text(
                      documentSnapshot["maxSpeed"].toString(),
                      style: Variables.blacktextstyle,
                    )
                  ],
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 130,
                width: 130,
                padding: Variables.padding,
                margin: Variables.margin,
                decoration: Variables.boxDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Variables.fuelicon,
                    Variables.sizebox,
                    Text("Fuel Type", style: Variables.textStyle),
                    Variables.sizebox,
                    Text(
                      documentSnapshot["fuelType"],
                      style: Variables.blacktextstyle,
                    )
                  ],
                ),
              ),
              Container(
                height: 130,
                width: 130,
                padding: Variables.padding,
                margin: Variables.margin,
                decoration: Variables.boxDecoration,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Variables.moneyicon,
                    Variables.sizebox,
                    Text(
                      "Rental Price",
                      style: Variables.textStyle,
                    ),
                    Variables.sizebox,
                    Row(
                      children: [
                        Variables.rupeeicon,
                        ClipRect(
                          child: Text(
                            documentSnapshot["carPrice"].toString(),
                            style: Variables.blacktextstyle,
                          ),
                        ),
                        Text(
                          "/Day",
                          style: Variables.blacktextstyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                FCM(documentSnapshot: documentSnapshot).listenFCM(context);
                String? fcmtoken = await FCM().firebaseMessaging.getToken();
                if (fcmtoken != null) {
                  FCM(documentSnapshot: documentSnapshot).sendNotification(fcmtoken);
                }
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.yellow,
                    content: Text("Your Booking Request is sent",style: TextStyle(color: Colors.black),)));
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Variables.bluecolor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    "Book Now",
                    style: Variables.whitetextstyle,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
