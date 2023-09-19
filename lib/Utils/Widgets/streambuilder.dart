import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hertzrentacar/Screens/rentalownerpage/cardetailsupload.dart';
import 'package:hertzrentacar/Utils/Widgets/elevatedbutton.dart';
import 'package:hertzrentacar/Utils/Widgets/widgetsandvariables.dart';
import 'package:provider/provider.dart';

import '../../Repositories/rentalownerrepo.dart';
import '../../Screens/userpage/viewvehicles.dart';
import '../providers.dart';

class StreamBuilder1 extends StatelessWidget {
  bool pageChange;
  StreamBuilder1({required this.pageChange, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<ProviderClass>(context).stream,
        builder: (context, snapshot1) {
          if (snapshot1.hasData) {
            return Expanded(
              child: GridView.builder(
                  itemCount: snapshot1.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 10,
                      childAspectRatio: 5 / 6),
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot1.data!.docs[index];
                    Map<String, dynamic> carDetails = {};
                    if (documentSnapshot.exists) {
                      carDetails =
                          documentSnapshot.data()! as Map<String, dynamic>;
                    }
                    return InkWell(
                      onTap: () {
                        pageChange == true
                            ? Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                return ViewVehicles(
                                  documentSnapshot: documentSnapshot,
                                );
                              }))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CarDetailsUpload(
                                          documentSnapshot: documentSnapshot,
                                        )));
                      },
                      child: Container(
                        height: 350,
                        width: 100,
                        margin: EdgeInsets.only(left: 15, right: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(1, 1),
                                color: Colors.grey,
                                blurRadius: 3),
                            BoxShadow(
                                offset: Offset(-1, -1),
                                color: Colors.grey,
                                blurRadius: 3)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: ListView(
                            children: [
                              SizedBox(
                                height: 3,
                              ),
                              Image(
                                  height: 100,
                                  width: 160,
                                  image: NetworkImage(
                                    documentSnapshot["carImage"],
                                  )),
                              Text(documentSnapshot["carNameAndModel"],
                                  style: Variables.blacktextstyle),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    color: Colors.grey,
                                  ),
                                  Text(documentSnapshot["carPrice"].toString(),
                                      style: Variables.blacktextstyle),
                                  Text(
                                    "/Day",
                                    style: Variables.blacktextstyle,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                        right: 15,
                                      ),
                                      child: pageChange == true
                                          ? Icon(
                                              Icons.favorite_border_rounded,
                                              size: 33,
                                              color: Colors.red,
                                            )
                                          : InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          actions: [
                                                            CustomElevatedButton(
                                                                text: "Yes",
                                                                onPressed: () {
                                                                  Rental().deleteCarDetails(
                                                                      context,
                                                                      documentSnapshot);
                                                                }),
                                                            CustomElevatedButton(
                                                                text: "No",
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                })
                                                          ],
                                                          title: Text(
                                                              "Do you want to delete this post?"));
                                                    });
                                              },
                                              child: Icon(
                                                Icons.delete_outline_rounded,
                                                size: 33,
                                                color: Colors.red,
                                              ))),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return SizedBox();
          }
        });
  }
}
