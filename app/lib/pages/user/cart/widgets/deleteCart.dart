import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/constants/theme.dart';

Future<void> deleteCart({context, id, onClickToCancel, onClickToDelete}) async {
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
                  "알림",
                  style: GoogleFonts.notoSans(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: Text(
                    "정말로 삭제하시겠습니까?\n삭제 후에는 되돌릴 수 없습니다",
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
                      onTap: onClickToDelete,
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 40,
                        alignment: Alignment.center,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: gradSig,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text(
                          "삭제",
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
