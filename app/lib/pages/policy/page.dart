import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import 'package:schooluniform/components/header2.dart';

class PolicyPage extends StatefulWidget {
  @override
  PolicyPageState createState() => PolicyPageState();
}

class PolicyPageState extends State<PolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Header2(
        popButton: true,
        title: Text(
          "개인정보 수집 및 이용",
          style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black),
        ),
        border: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 36, horizontal: 16),
        children: [
          Container(
            child: Text(
              "개인정보 수집 및 이용동의 전문",
              style: GoogleFonts.notoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff444444),
                  height: 1),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 24,
              bottom: 16,
            ),
            child: Text(
              "본인은 「개인정보 보호법」제15조제1항에 의거, 다음과 같이 본인의 개인정보를 수집ㆍ이용하는 것에 대하여 동의합니다.",
              style: GoogleFonts.notoSans(
                  fontSize: 13,
                  height: 1.57,
                  color: Color(0xff444444),
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 4, top: 1),
                  child: Text(
                    "가.",
                    style: GoogleFonts.notoSans(
                        fontSize: 14, color: Color(0xff444444), height: 1.57),
                  ),
                ),
                Flexible(
                  child: Text(
                    "개인정보의 수집ㆍ이용자(개인정보처리자) : 북구청, 북구자원봉사센터",
                    style: GoogleFonts.notoSans(
                        fontSize: 14, color: Color(0xff444444), height: 1.57),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 4, top: 1),
                  child: Text(
                    "나.",
                    style: GoogleFonts.notoSans(
                        fontSize: 14, color: Color(0xff444444), height: 1.57),
                  ),
                ),
                Flexible(
                  child: Text(
                    "개인정보의 수집ㆍ이용 목적 : 기부물품 처리 관련 업무(신청내역확인, 물품 수거 및 발송 등)",
                    style: GoogleFonts.notoSans(
                        fontSize: 14, color: Color(0xff444444), height: 1.57),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 4, top: 1),
                  child: Text(
                    "다.",
                    style: GoogleFonts.notoSans(
                        fontSize: 14, color: Color(0xff444444), height: 1.57),
                  ),
                ),
                Flexible(
                  child: Text(
                    "개인정보의 수집ㆍ이용 항목 : 성명, 연락처, 주소 등",
                    style: GoogleFonts.notoSans(
                        fontSize: 14, color: Color(0xff444444), height: 1.57),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 4, top: 1),
                  child: Text(
                    "라.",
                    style: GoogleFonts.notoSans(
                        fontSize: 14, color: Color(0xff444444), height: 1.57),
                  ),
                ),
                Flexible(
                  child: Text(
                    "개인정보의 보유 및 이용기간 : 1년",
                    style: GoogleFonts.notoSans(
                        fontSize: 14, color: Color(0xff444444), height: 1.57),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
