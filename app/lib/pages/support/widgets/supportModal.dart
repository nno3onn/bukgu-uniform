import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/constants/theme.dart';

void openSupportModal({context, onClick}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 206,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width - 32,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 6),
                            child: Image(
                                image:
                                    AssetImage("assets/icon/close-white.png"),
                                width: 16,
                                height: 16),
                          ),
                          Text(
                            "닫기",
                            style: GoogleFonts.notoSans(
                                fontSize: 14, color: Colors.white),
                          )
                        ],
                      ),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 170,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "대구은행 040-05-002917-3",
                          style: GoogleFonts.notoSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Text(
                            "예금주 : 사회복지공동모금회 대구",
                            style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: Color(0xff666666),
                                height: 1),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        GestureDetector(
                          onTap: onClick,
                          child: Container(
                            decoration: BoxDecoration(
                              color: grey2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              "계좌번호 복사",
                              style: GoogleFonts.notoSans(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )));
}
