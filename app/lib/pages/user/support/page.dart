import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/components/header.dart';

class UserSupportPage extends StatefulWidget {
  static String url = "/user/support";

  @override
  UserSupportPageState createState() => UserSupportPageState();
}

class UserSupportPageState extends State<UserSupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(popButton: true, title: Text("나의 후원 내역", style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black),), border: false,),
      body: Container(),
    );
  }
}
