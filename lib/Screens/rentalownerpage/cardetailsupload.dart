import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hertzrentacar/Utils/Widgets/elevatedbutton.dart';
import 'package:hertzrentacar/Utils/Widgets/textfield.dart';

import '../../Repositories/rentalownerrepo.dart';
import '../../Utils/functions.dart';

class CarDetailsUpload extends StatefulWidget {
  final DocumentSnapshot? documentSnapshot;
  var showImage;
  CarDetailsUpload({this.showImage, this.documentSnapshot});

  @override
  State<CarDetailsUpload> createState() => _CarDetailsUploadState();
}

class _CarDetailsUploadState extends State<CarDetailsUpload> {
  final formKey = GlobalKey<FormState>();

  final sizedbox = SizedBox(
    height: 20,
  );

  @override
  void initState() {
    super.initState();
    if (widget.documentSnapshot != null && widget.documentSnapshot!.exists) {
      companyName.text = widget.documentSnapshot!["companyName"];
      carNameandModel.text = widget.documentSnapshot!["carNameAndModel"];
      carNo.text=widget.documentSnapshot!["carCapacity"];
      engineType.text=widget.documentSnapshot!["maxSpeed"];
      fuelType.text=widget.documentSnapshot!["fuelType"];
      carPrice.text=widget.documentSnapshot!["carPrice"].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading:InkWell(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back)),title: Text("Editing CarDetails"),),
        body: SingleChildScrollView(
      child: SafeArea(
          child: Center(
              child: Form(
        key: formKey,
        child: Column(
          children: [
            Image(
                height: 150,
                width: 150,
                image: NetworkImage(widget.documentSnapshot != null
                    ? widget.documentSnapshot!["carImage"]
                    : widget.showImage)),
            TextFields(
              controller: companyName,
              hintText: "Your Rental Company Name",
            ),
            sizedbox,
            TextFields(
                controller: carNameandModel, hintText: "Car Name and Model"),
            sizedbox,
            TextFields(controller: carNo, hintText: "seats capacity"),
            sizedbox,
            TextFields(controller: engineType, hintText: "Max Speed (km/h)"),
            sizedbox,
            TextFields(controller: fuelType, hintText: "Fuel Type"),
            sizedbox,
            TextFields(controller: carPrice, hintText: "Car price for per day"),
            sizedbox,
            CustomElevatedButton(
                text: "Upload",
                onPressed: () {
                  if(widget.documentSnapshot!=null && widget.documentSnapshot!.exists){
                    Rental().updateCarDetails(context,widget.documentSnapshot!);
                  }
                  else{
                    Rental().saveCarDetails(context, widget.showImage, formKey);

                  }
                  // widget.documentSnapshot!=null?Rental().updateCarDetails(context,widget.documentSnapshot!):
                  carPrice.clear();
                  carNo.clear();
                  carNameandModel.clear();
                  companyName.clear();
                  engineType.clear();
                  fuelType.clear();
                })
          ],
        ),
      ))),
    ));
  }
}

//
