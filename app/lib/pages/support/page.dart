import 'package:clipboard/clipboard.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schooluniform/components/header.dart';
import 'package:schooluniform/constants/theme.dart';
import 'package:schooluniform/pages/support/widgets/supportModal.dart';
import 'package:schooluniform/pages/support/widgets/recModal.dart';

class SupportPage extends StatefulWidget {
  static String url = "/support";

  @override
  SupportPageState createState() => SupportPageState();
}

class SupportPageState extends State<SupportPage> {
  FToast fToast;

  void handleCopy() async {
    await FlutterClipboard.copy("040050029173");
    Widget toast = Container(
      padding: EdgeInsets.only(top: 10, right: 24, bottom: 10, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.0),
        gradient: gradSig,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
              image: AssetImage("assets/icon/toast-check.png"),
              width: 24,
              height: 24),
          SizedBox(
            width: 10.0,
          ),
          Text(
            "복사되었습니다",
            style: GoogleFonts.notoSans(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: Header(
          popButton: true,
          title: Text(
            "행복북구 희망은행 후원하기",
            style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black),
          ),
          border: true,
        ),
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.only(
                    top: 32,
                    left: 16,
                    right: 16,
                    bottom: 160 + MediaQuery.of(context).padding.bottom),
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Text(
                      "행복북구 희망은행 사업안내",
                      style: GoogleFonts.notoSans(
                          fontSize: 20, fontWeight: FontWeight.bold, height: 1),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 36),
                    child: Text(
                      "행복북구 희망은행은 따뜻한 나눔으로 어려운 환경에 처한 이들의 희망 키움과 자립의지를 도와 행복한 북구를 만들기 위한 사업입니다.",
                      style: GoogleFonts.notoSans(
                          fontSize: 14, height: 1.57, color: Color(0xff444444)),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        width: 3,
                        height: 12,
                        decoration: BoxDecoration(
                          gradient: gradSig,
                        ),
                      ),
                      Text(
                        "꿈누리장학금 지원",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 16, bottom: 36),
                      child: Text(
                        "어려운 환경 속에서도 열심히 공부하는 저소득 학생에게 장학금 지원으로 밝은 미래를 선물합니다.",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            height: 1.57,
                            color: Color(0xff444444)),
                      )),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        width: 3,
                        height: 12,
                        decoration: BoxDecoration(
                          gradient: gradSig,
                        ),
                      ),
                      Text(
                        "희망고리잇기 지원",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 16, bottom: 36),
                      child: Text(
                        "지속적인 관심과 도움이 필요한 가구에 결원 후원금 지원으로 희망찬 내일을 선물합니다.",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            height: 1.57,
                            color: Color(0xff444444)),
                      )),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        width: 3,
                        height: 12,
                        decoration: BoxDecoration(
                          gradient: gradSig,
                        ),
                      ),
                      Text(
                        "따뜻한 겨울나기 난방비 지원",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 16, bottom: 36),
                      child: Text(
                        "어려운 이웃이 따뜻한 겨울을 보낼 수 있도록 난방비를 지원합니다.",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            height: 1.57,
                            color: Color(0xff444444)),
                      )),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        width: 3,
                        height: 12,
                        decoration: BoxDecoration(
                          gradient: gradSig,
                        ),
                      ),
                      Text(
                        "동화나라 버스도서관 지원",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 16, bottom: 36),
                      child: Text(
                        "어린이들에게 꿈과 희망을 주는 버스도서관의 원활한 운영을 위해 지원합니다.",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            height: 1.57,
                            color: Color(0xff444444)),
                      )),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        width: 3,
                        height: 12,
                        decoration: BoxDecoration(
                          gradient: gradSig,
                        ),
                      ),
                      Text(
                        "꽃보다 가족",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 16, bottom: 36),
                      child: Text(
                        "지속적인 관심과 도움이 필요한 가구에 결원 후원금 지원으로 희망찬 내일을 선물합니다.",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            height: 1.57,
                            color: Color(0xff444444)),
                      )),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        width: 3,
                        height: 12,
                        decoration: BoxDecoration(
                          gradient: gradSig,
                        ),
                      ),
                      Text(
                        "꿈꾸는 BOOKIDS 꿈지원",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 16, bottom: 36),
                      child: Text(
                        "초등학교 6학년 아동을 대상으로 올바른 독서습관 형성을 통해 자신의 꿈을 펼칠 수 있는 기회를 선물합니다.",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            height: 1.57,
                            color: Color(0xff444444)),
                      )),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        width: 3,
                        height: 12,
                        decoration: BoxDecoration(
                          gradient: gradSig,
                        ),
                      ),
                      Text(
                        "맞춤형 복지기획",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 16, bottom: 36),
                      child: Text(
                        "예측 불가능한 복지 수요 파악으로 맞춤형 서비스를 제공합니다.",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            height: 1.57,
                            color: Color(0xff444444)),
                      )),
                ],
              ),
              Positioned(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 24,
                        top: 24),
                    decoration: BoxDecoration(color: Colors.white),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          child: GestureDetector(
                              onTap: () => openSupportModal(
                                  context: context,
                                  onClick: () => handleCopy()),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 32,
                                height: 52,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  gradient: gradSig,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 12),
                                        blurRadius: 16,
                                        spreadRadius: -8,
                                        color: colorSig2)
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Text(
                                  "후원하기",
                                  style: GoogleFonts.notoSans(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ),
                        GestureDetector(
                            onTap: () => openRecModal(context: context),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 32,
                              height: 52,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: grey6,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Text(
                                "기부 영수증 발급",
                                style: GoogleFonts.notoSans(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    ),
                  ),
                  bottom: 0)
            ],
          ),
        ));
  }
}
