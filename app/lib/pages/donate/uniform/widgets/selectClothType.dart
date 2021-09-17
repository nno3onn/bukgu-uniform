import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/constants/theme.dart';

class SelectClothTypeWidget extends StatelessWidget {
  final String clothType;
  final String label;
  final Function onClick;

  SelectClothTypeWidget({
    this.clothType,
    this.label,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 46,
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 18,
              height: 18,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: clothType == label ? Colors.black : grey6)),
              child: clothType == label
                  ? Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    )
                  : Container(),
            ),
            Text(
              label,
              style: GoogleFonts.notoSans(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
