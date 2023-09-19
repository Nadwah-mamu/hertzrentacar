import 'package:flutter/material.dart';
import 'package:hertzrentacar/Utils/Widgets/appbar.dart';
import 'package:hertzrentacar/Utils/Widgets/bottomsheet.dart';
import 'package:hertzrentacar/Utils/Widgets/streambuilder.dart';

import '../../Utils/Widgets/widgetsandvariables.dart';
import 'editprofile.dart';

class HomePage1 extends StatelessWidget {
  HomePage1({Key? key}) : super(key: key);

  final searchfield = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: logoAppbar,
      body: Column(
        children: [
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40)),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    opacity: 1,
                    image: AssetImage(
                      "assets/download.jpeg",
                    ))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.favorite_outline,
                        color: Variables.bluecolor,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return EditProfile();
                          }));
                        },
                        child: const CircleAvatar(radius: 20,backgroundImage: AssetImage("assets/downloadprofile.png"),)
                      )
                    ],
                  ),
                ),
                Text(
                  "Choose a Car",
                  style:Variables.bluetextstyle
                ),
                Row(
                  children: [
                    Container(
                      width: 280,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        controller: searchfield,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search_outlined,
                              color: Variables.bluecolor,
                              size: 28,
                            ),
                            hintText: "Search your Dream Car ...",
                            hintStyle:Variables.textStyle,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        BottomSheet1().bottomSheet(context);
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.only(top: 5, left: 13),
                        decoration: BoxDecoration(
                          color: Variables.bluecolor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.sort,
                          color: Colors.white,
                          size: 33,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          sizedbox,
          StreamBuilder1(pageChange: true)
        ],
      ),
    );
  }
}
