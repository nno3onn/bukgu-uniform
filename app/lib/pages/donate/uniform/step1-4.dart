import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import 'package:schooluniform/constants/theme.dart';
import 'package:schooluniform/pages/donate/uniform/types/donateState1_4Data.dart';

import 'package:schooluniform/components/header.dart';
import 'package:schooluniform/pages/donate/uniform/widgets/selectClothType.dart';

class DonateStep1_4 extends StatefulWidget {
  @override
  DonateStep1_4State createState() => DonateStep1_4State();
}

class DonateStep1_4State extends State<DonateStep1_4> {
  String clothType;
  String size;

  handleClothType(String g) {
    // Navigator.of(context).pop(g);
    setState(() {
      clothType = g;
    });
  }

  @override
  Widget build(BuildContext context) {
    DonateState1_4InputData data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: Header(
          title: Text("교복 기부하기",
              style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black)),
          popButton: true,
          border: true,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "종류를 선택하세요",
                style: GoogleFonts.notoSans(
                    fontSize: 24, fontWeight: FontWeight.w300, height: 1),
              ),
            ),
            data.season == "동복"
                ? SelectClothTypeWidget(
                    clothType: clothType,
                    label: "자켓",
                    onClick: () => handleClothType("자켓"),
                  )
                : Container(),
            data.season == "동복" || data.season == "하복"
                ? SelectClothTypeWidget(
                    clothType: clothType,
                    label: "셔츠",
                    onClick: () => handleClothType("셔츠"),
                  )
                : SelectClothTypeWidget(
                    clothType: clothType,
                    label: "상의",
                    onClick: () => handleClothType("상의"),
                  ),
            data.season == "동복"
                ? SelectClothTypeWidget(
                    clothType: clothType,
                    label: "조끼",
                    onClick: () => handleClothType("조끼"),
                  )
                : Container(),
            data.season == "동복" || data.season == "하복"
                ? SelectClothTypeWidget(
                    clothType: clothType,
                    label: "바지",
                    onClick: () => handleClothType("바지"),
                  )
                : SelectClothTypeWidget(
                    clothType: clothType,
                    label: "하의",
                    onClick: () => handleClothType("하의"),
                  ),
            (data.season == "동복" || data.season == "하복") && data.gender == "여자"
                ? SelectClothTypeWidget(
                    clothType: clothType,
                    label: "치마",
                    onClick: () => handleClothType("치마"),
                  )
                : Container(),
            data.season == "동복" || data.season == "하복"
                ? SelectClothTypeWidget(
                    clothType: clothType,
                    label: "넥타이",
                    onClick: () => handleClothType("넥타이"),
                  )
                : Container(),
            clothType == null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        border:
                            Border(top: BorderSide(color: grey2, width: 1))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "사이즈 입력",
                            style: GoogleFonts.notoSans(fontSize: 12),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: grey3)),
                            child: TextField(
                              onChanged: (text) {
                                setState(() {
                                  size = text;
                                });
                              },
                              cursorColor: colorSig1,
                              keyboardType: TextInputType.text,
                              decoration: deco("옷 사이즈를 입력해주세요"),
                              maxLength: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            clothType == null || size == null || size == ""
                ? Container()
                : Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 24),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(
                          DonateState1_4OutputData(
                              clothType: clothType, size: size)),
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: gradSig,
                            boxShadow: [shadowSig]),
                        padding: EdgeInsets.all(18),
                        child: Image(
                          image:
                              AssetImage("assets/icon/arrow-right-white.png"),
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ))
          ],
        ));
  }
}
