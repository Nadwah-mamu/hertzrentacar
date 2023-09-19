import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../Utils/Widgets/appbar.dart';
import '../../Utils/providers.dart';
import 'package:hertzrentacar/Screens/rentalownerpage/addcars.dart';

import 'accountsettings.dart';



class HomePage extends StatelessWidget {
  List pages = [AddCars(), Profile()];

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ProviderClass>(context);
    return Scaffold(
      appBar:logoAppbar,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        currentIndex: provider.selectedIndex,
        iconSize: 30,
        selectedIconTheme: IconThemeData(size: 33),
        selectedFontSize: 20,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: "Profile"),
        ],
        onTap: (v) {
          Provider.of<ProviderClass>(context,listen: false).updateSelectedIndex(v);
        },
      ),
      body: pages[provider.selectedIndex]
    );
  }
}
