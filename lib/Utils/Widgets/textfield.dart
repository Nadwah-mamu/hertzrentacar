import 'package:flutter/material.dart';


final color = Colors.black38;

class TextFields extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? initialValue;
  final TextInputType? keyboardType;

  TextFields({this.controller,this.hintText,this.onChanged, this.initialValue,this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "*mandatory field";
        }
      },
      controller: controller,
      onChanged: onChanged,
      initialValue: initialValue,
      cursorColor: color,
      keyboardType:keyboardType ,
      decoration: InputDecoration(
          labelText: hintText,
          floatingLabelStyle: TextStyle(fontSize: 20, color: color),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: color))),
    );
  }
}
