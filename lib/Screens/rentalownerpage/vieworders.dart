import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hertzrentacar/Repositories/rentalownerrepo.dart';
import 'package:hertzrentacar/Utils/Widgets/elevatedbutton.dart';
import 'package:hertzrentacar/Utils/Widgets/icons.dart';


class ViewOrders extends StatelessWidget {
  DocumentSnapshot? documentSnapshot;
  ViewOrders({this.documentSnapshot});

  final textstyle = TextStyle(fontSize: 23, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 10, top: 10),
            margin: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
                color: Colors.yellow.shade400,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.yellow.shade700, width: 2.5),
                boxShadow: [
                  BoxShadow(blurRadius: 10, color: Colors.yellow.shade400)
                ]),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You've got Order",
                  style: textstyle,
                ),
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(documentSnapshot!["carImage"]))),
                    ),
                    Column(
                      children: [
                        Text(
                          documentSnapshot!["carNameAndModel"],
                          style: textstyle,
                        ),
                        Text(
                          documentSnapshot!["carPrice"],
                          style: TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: [
                            circleIcon,
                            Text(documentSnapshot!["fuelType"]),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            circleIcon,
                            Text(documentSnapshot!["carCapacity"]),
                            Text("Seats")
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            circleIcon,
                            Text(documentSnapshot!["maxSpeed"]),
                            Text("km/h")
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomElevatedButton(text: "Cancel", onPressed:(){
                Rental().notifReject(context);
              }),
              SizedBox(
                width: 9,
              ),
              //Accepting notification
              CustomElevatedButton(text: "Accept", onPressed: (){
                Rental().notifAccept(context);
              }),
              SizedBox(
                width: 9,
              )
            ],
          )
        ],
      ),
    ));
  }
}
