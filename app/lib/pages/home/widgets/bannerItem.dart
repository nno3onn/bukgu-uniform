import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/constants/theme.dart';

class BannerItemWidget extends StatelessWidget {
  final Color bg;
  final String url;
  final String imageSrc;
  final String label;
  final String secondaryLabel;
  BannerItemWidget(
      {this.bg, this.url, this.imageSrc, this.label, this.secondaryLabel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(url),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      label,
                      style: GoogleFonts.notoSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: textHeading1,
                          height: 1),
                    ),
                  ),
                  Text(
                    secondaryLabel,
                    style: GoogleFonts.notoSans(
                        fontSize: 10, color: textContent1, height: 1),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 8),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular((8))),
                image: DecorationImage(
                  image: AssetImage(imageSrc),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
