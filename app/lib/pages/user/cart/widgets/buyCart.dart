import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/constants/theme.dart';

void buy({context, onClickToCancel, onClickToBuy}) {
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
          width: MediaQuery.of(context).size.width - 32,
          padding: EdgeInsets.only(top: 36, bottom: 24, left: 16, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Container(
            height: 155,
            child: Column(
              children: [
                Text(
                  "주의사항",
                  style: GoogleFonts.notoSans(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: Text(
                    "모든 신청이 수락되지는 않으며\n너무 빈번한 구매는 거절 당할 수 있습니다",
                    style: GoogleFonts.notoSans(
                        fontSize: 14, color: Color(0xff444444), height: 1.57),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onClickToCancel,
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 40,
                        alignment: Alignment.center,
                        height: 52,
                        decoration: BoxDecoration(
                          color: grey3,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text(
                          "취소",
                          style: GoogleFonts.notoSans(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onClickToBuy,
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 40,
                        alignment: Alignment.center,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: gradSig,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text(
                          "확인했습니다",
                          style: GoogleFonts.notoSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )),
  );
}
