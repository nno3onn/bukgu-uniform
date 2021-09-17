import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import 'package:schooluniform/components/header.dart';

class DonateThingParking extends StatefulWidget {
  @override
  DonateThingParkingState createState() => DonateThingParkingState();
}

class DonateThingParkingState extends State<DonateThingParking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        popButton: true,
        title: Text(
          "물품 기부하기",
          style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black),
        ),
        border: false,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage("assets/img/bookie-parking.png"),
                  width: 100,
                  height: 100),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 100),
                child: Text(
                  "서비스 예정입니다",
                  style: GoogleFonts.notoSans(
                      fontSize: 14, color: Color(0xff444444)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
