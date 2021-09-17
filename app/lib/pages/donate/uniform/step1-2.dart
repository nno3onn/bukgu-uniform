import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import 'package:schooluniform/components/header2.dart';
import 'package:schooluniform/pages/donate/uniform/widgets/selectGender.dart';

class DonateStep1_2 extends StatefulWidget {
  @override
  DonateStep1_2State createState() => DonateStep1_2State();
}

class DonateStep1_2State extends State<DonateStep1_2> {
  String gender;

  handleGender(String g) {
    Navigator.of(context).pop(g);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: Header2(
          title: Text("교복 기부하기",
              style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black)),
          popButton: true,
          border: true,
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "성별을 선택하세요",
                      style: GoogleFonts.notoSans(
                          fontSize: 24, fontWeight: FontWeight.w300, height: 1),
                    ),
                  ),
                  SelectGenderWidget(
                    gender: gender,
                    label: "남자",
                    onClick: () => handleGender("남자"),
                  ),
                  SelectGenderWidget(
                    gender: gender,
                    label: "여자",
                    onClick: () => handleGender("여자"),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
