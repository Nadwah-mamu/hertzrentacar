import 'package:flutter/material.dart';
import 'package:hertzrentacar/Utils/Widgets/widgetsandvariables.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Repositories/imagePicker.dart';
import '../../Repositories/userRepo.dart';
import '../providers.dart';

String brands = "";

String carnames = "";

//for Visibility widget
bool isBrandsClicked = false;

bool isPriceClicked = false;

bool isRentalClicked = false;

class BottomSheet1 {
  filterBrands(Object carName, BuildContext context) {
    Provider.of<ProviderClass>(context, listen: false).streamChange(
        stream1: fireStore
            .collection("cardetails")
            .where('carNameAndModel', isEqualTo: carName)
            .snapshots());
  }

  filterRentalCompany(Object companyName, BuildContext context) {
    Provider.of<ProviderClass>(context, listen: false).stream1Change(
        stream2: fireStore
            .collection("cardetails")
            .where("companyName", isEqualTo: companyName)
            .snapshots());
  }

  filterCost(bool value, BuildContext context) {
    Provider.of<ProviderClass>(context, listen: false).stream2Change(
        stream3: fireStore
            .collection("cardetails")
            .orderBy('carPrice', descending: value)
            .snapshots());
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter state) {
            return Container(
              padding: EdgeInsets.only(top: 5, left: 8, right: 15),
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SORT BY",
                    style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 18,
                        color: Colors.black38,
                        fontWeight: FontWeight.w400),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Radio(
                          activeColor: Variables.bluecolor,
                          value: "brands",
                          groupValue: brands,
                          onChanged: (v) {
                            state(() {
                              brands = v!;
                              isBrandsClicked = true;
                              isRentalClicked = false;
                              isPriceClicked = false;
                            });
                          }),
                      Text(
                        "Brands",
                        style: Variables.blacktextstyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          activeColor: Variables.bluecolor,
                          value: "rentalcompany",
                          groupValue: brands,
                          onChanged: (v) {
                            state(() {
                              brands = v!;
                              isRentalClicked = true;
                              isBrandsClicked = false;
                              isPriceClicked = false;
                            });
                          }),
                      Text(
                        "Rental Company",
                        style: Variables.blacktextstyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          activeColor: Variables.bluecolor,
                          value: "Price",
                          groupValue: brands,
                          onChanged: (v) {
                            state(() {
                              brands = v!;
                              isPriceClicked = true;
                              isBrandsClicked = false;
                              isRentalClicked = false;
                            });
                          }),
                      Text(
                        "Price",
                        style: Variables.blacktextstyle,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Visibility(
                    visible: isBrandsClicked,
                    child: Row(children: [
                      Radio(
                          activeColor: Variables.bluecolor,
                          value: "Volkswagen",
                          groupValue: carnames,
                          onChanged: (v) {
                            state(() {
                              carnames = v!;
                              filterBrands("volkswagen", context);
                            });
                          }),
                      Text(
                        "Volkswagen",
                        style: Variables.blacktextstyle,
                      ),
                      Radio(
                          activeColor: Variables.bluecolor,
                          value: "hyundai",
                          groupValue: carnames,
                          onChanged: (v) {
                            state(() {
                              carnames = v!;
                              filterBrands("hyundai", context);
                            });
                          }),
                      Text(
                        "Hyundai",
                        style: Variables.blacktextstyle,
                      ),
                    ]),
                  ),
                  Visibility(
                    visible: isBrandsClicked,
                    child: Row(children: [
                      Radio(
                          activeColor: Variables.bluecolor,
                          value: "Toyota",
                          groupValue: carnames,
                          onChanged: (v) {
                            state(() {
                              carnames = v!;
                              filterBrands("Toyota", context);
                            });
                          }),
                      Text(
                        "Toyota",
                        style: Variables.blacktextstyle,
                      ),
                      Radio(
                          activeColor: Variables.bluecolor,
                          value: "Ford",
                          groupValue: carnames,
                          onChanged: (v) {
                            state(() {
                              carnames = v!;
                              filterBrands("ford", context);
                            });
                          }),
                      Text(
                        "Ford",
                        style: Variables.blacktextstyle,
                      ),
                    ]),
                  ),
                  Visibility(
                    visible: isRentalClicked,
                    child: Row(children: [
                      Radio(
                          activeColor: Variables.bluecolor,
                          value: "superDrive",
                          groupValue: carnames,
                          onChanged: (v) {
                            state(() {
                              carnames = v!;
                              filterRentalCompany("Superdrive", context);
                            });
                          }),
                      Text(
                        "SuperDrive",
                        style: Variables.blacktextstyle,
                      ),
                      Radio(
                          activeColor: Variables.bluecolor,
                          value: "easydrive",
                          groupValue: carnames,
                          onChanged: (v) {
                            state(() {
                              carnames = v!;
                              filterRentalCompany("Easydrive", context);
                            });
                          }),
                      Text(
                        "EasyDrive",
                        style: Variables.blacktextstyle,
                      ),
                    ]),
                  ),
                  Visibility(
                    visible: isPriceClicked,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          Radio(
                              activeColor: Variables.bluecolor,
                              value: "costhightolow",
                              groupValue: carnames,
                              onChanged: (v) {
                                state(() {
                                  carnames = v!;
                                  filterCost(true, context);
                                });
                              }),
                          Text(
                            "Cost : High to Low",
                            style: Variables.blacktextstyle,
                          ),
                        ]),
                        Row(
                          children: [
                            Radio(
                                activeColor: Variables.bluecolor,
                                value: "costlowtohigh",
                                groupValue: carnames,
                                onChanged: (v) {
                                  state(() {
                                    carnames = v!;
                                    filterCost(false, context);
                                  });
                                }),
                            Text(
                              "Cost : Low to High",
                              style: Variables.blacktextstyle,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isBrandsClicked == true ||
                          isRentalClicked == true ||
                          isPriceClicked == true
                      ? ElevatedButton(
                          style: Variables.buttoncolor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Apply Filter",
                            style: Variables.whitetextstyle,
                          ))
                      : SizedBox()
                ],
              ),
            );
          });
        });
  }

  imagePickBottomSheet(BuildContext context, bool profilePhoto) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        profilePhoto == true
                            ? Images()
                                .pickProfilePhoto(context, ImageSource.camera)
                            : Images().passImage(context, ImageSource.camera);
                      },
                      child: Text(
                        "Take a photo",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.photo,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        profilePhoto == true
                            ? Images()
                            .pickProfilePhoto(context, ImageSource.gallery)
                            : Images().passImage(context, ImageSource.gallery);                      },
                      child: Text(
                        "Choose image from gallery",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
