import 'package:flutter/material.dart';

class ButtonCentralStyle {
  static const elevatedButtonStyleActive = ButtonStyle(
      minimumSize: MaterialStatePropertyAll(Size(45, 65)),
      elevation: MaterialStatePropertyAll(10),
      backgroundColor: MaterialStatePropertyAll(Colors.black),
      shadowColor: MaterialStatePropertyAll(Colors.grey));
  static const elevatedButtinStyleInactive = ButtonStyle(
      backgroundColor:
          MaterialStatePropertyAll(Color.fromRGBO(236, 181, 28, 1)),
      elevation: MaterialStatePropertyAll(5),
      minimumSize: MaterialStatePropertyAll(Size(45, 65)));
}
