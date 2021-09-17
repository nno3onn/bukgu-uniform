import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/configs/api/networkHandler.dart';
import 'package:schooluniform/configs/routes.dart';
import 'package:schooluniform/constants/theme.dart';

Widget card({context, data}) {
  return GestureDetector(
    onTap: () {
      if (data["showStatus"] == "거절") {
        Navigator.of(context).pushNamed(Routes.userPurchaseUniformRejectUrl,
            arguments: data["uniformId"]);
      }
    },
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkHandler().getImage(data["thumbnail"]),
                      fit: BoxFit.cover),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 144,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      data["title"] ??
                          "afdadfasdfasdfasdfasdfasfdasdfasfdasfdasfdasdf",
                      style: GoogleFonts.notoSans(fontSize: 14, height: 1.57),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(data["showStatus"],
                      style: GoogleFonts.notoSans(
                          fontSize: 12,
                          color: data["showStatus"] != "거절"
                              ? colorSubBlue
                              : colorRejectRed)),
                ],
              )
            ],
          ),
          data["showStatus"] == "거절"
              ? (Icon(
                  Icons.help_outline_outlined,
                  color: colorRejectRed,
                  size: 20,
                ))
              : Container(),
        ],
      ),
    ),
  );
}
