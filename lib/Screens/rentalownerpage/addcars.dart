import 'package:flutter/material.dart';
import 'package:hertzrentacar/Utils/Widgets/bottomsheet.dart';
import 'package:hertzrentacar/Utils/Widgets/streambuilder.dart';


class AddCars extends StatelessWidget {
  AddCars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
            SizedBox(height: 10,),
        StreamBuilder1(
          pageChange: false,
        )
      ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          BottomSheet1().imagePickBottomSheet(context, false);
        },
        child: Icon(
          Icons.camera_alt_rounded,
          size: 28,
        ),
      ),
    );
  }
}
