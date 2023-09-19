import 'package:flutter/material.dart';

import '../Repositories/userRepo.dart';

//Variables
TextEditingController email = TextEditingController();

final password = TextEditingController();
final name = TextEditingController();
final mobno = TextEditingController();



final companyName=TextEditingController();
final carNameandModel = TextEditingController();
final carPrice = TextEditingController();
final carNo = TextEditingController();
final engineType = TextEditingController();
final fuelType = TextEditingController();


final carPrices=int.parse(carPrice.text);