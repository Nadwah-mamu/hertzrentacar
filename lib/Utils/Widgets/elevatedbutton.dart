import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hertzrentacar/Utils/Widgets/widgetsandvariables.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomElevatedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text,style: Variables.whitetextstyle,),
      style: Variables.buttoncolor,
    );
  }
}
