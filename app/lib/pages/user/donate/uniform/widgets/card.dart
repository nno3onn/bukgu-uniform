import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/configs/api/networkHandler.dart';

import 'package:schooluniform/constants/theme.dart';

Widget card({context, data}) {
  print(data['thumbnail']);
  print(data);
  return Container(
    color: Colors.white,
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: data['thumbnail'] == null
                      ? AssetImage('assets/img/bookie-main.png')
                      : NetworkHandler().getImage(data['thumbnail']))),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 112,
              margin: EdgeInsets.only(bottom: 8),
              child: Text(
                data["title"] ??
                    "afdadfasdfasdfasdfasdfasfdasdfasfdasfdasfdasdf",
                style: GoogleFonts.notoSans(fontSize: 14, height: 1.57),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(data["showStatus"],
                style: GoogleFonts.notoSans(fontSize: 12, color: colorSubBlue)),
          ],
        )
      ],
    ),
  );
}
