import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/configs/stores.dart';
import 'package:schooluniform/constants/theme.dart';
import 'package:url_launcher/url_launcher.dart';

void openRecModal({
  context,
}) {
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
                          "기부 영수증 발급을 원하시는 분은\n아래 연락처로 연락 해주세요",
                          style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: Color(0xff888888),
                              height: 1.57),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "대구광역시 북구청 담당자",
                            style:
                                GoogleFonts.notoSans(fontSize: 14, height: 1),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => launch(
                              "tel:${infoStore.localInfo["officePhoneDonation"]}"),
                          child: Text(
                            infoStore.localInfo["officePhoneDonation"],
                            style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: colorSubBlue,
                                decoration: TextDecoration.underline),
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
