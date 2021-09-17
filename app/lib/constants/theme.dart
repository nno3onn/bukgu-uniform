import 'package:flutter/material.dart';

Color colorSig1 = Color(0xffFF4A4A);
Color colorSig2 = Color(0xffFF4A68);
LinearGradient gradSig = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      colorSig1,
      colorSig2,
    ]);
Color colorSubBlue = Color(0xff4aa8ff);
Color colorRejectRed = Color(0xffff4a4a);

Color colorAlert = Color(0xffFF0D15);
Color grey1 = Color(0xffF9F9FC);
Color grey2 = Color(0xffF4F4F7);
Color grey3 = Color(0xffEBEBF0);
Color grey4 = Color(0xffe1e1e8);
Color grey5 = Color(0xffd7d7e0);
Color grey6 = Color(0xffC5C5D1);
Color textGrey1 = Color(0xff888888);
Color textGrey2 = Color(0xff444444);

Color textHeading1 = Color(0xff3C3D42);
Color textContent1 = Color(0xff4D4E53);

BoxShadow shadowSig = BoxShadow(
    offset: Offset(0, 12),
    blurRadius: 24,
    spreadRadius: -8,
    color: Color(0x8cff4a68));

InputDecoration deco(String hintText) {
  return InputDecoration(
    counterStyle: TextStyle(
      height: double.minPositive,
    ),
    counterText: "",
    enabledBorder: InputBorder.none,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    isDense: true,
    labelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    contentPadding: EdgeInsets.all(0),
    hintText: hintText,
    hintStyle: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xffb7b7b7)),
  );
}
