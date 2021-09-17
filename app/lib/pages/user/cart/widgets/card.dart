import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/configs/api/networkHandler.dart';
import 'package:schooluniform/configs/routes.dart';
import 'package:schooluniform/constants/theme.dart';

Widget card({context, data, itemCode, onClickToItem, onClickToDeleteWidget}) {
  print(itemCode);
  print(data);
  return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onClickToItem,
                child: Container(
                  height: 46,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 18,
                        height: 18,
                        margin: EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: itemCode == data["uniformId"]
                                    ? Colors.black
                                    : grey6)),
                        child: itemCode == data["uniformId"]
                            ? Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                              )
                            : Container(),
                      ),
                      Text(
                        "선택",
                        style: GoogleFonts.notoSans(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                  onTap: onClickToDeleteWidget,
                  child: Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Image(
                      width: 12,
                      height: 12,
                      image: AssetImage("assets/icon/close-small.png"),
                    ),
                  ))
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                Routes.shopShowDirectUrl,
                arguments: data["uniformId"]),
            child: Row(
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
                      width: MediaQuery.of(context).size.width - 112,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        data["title"] ??
                            "afdadfasdfasdfasdfasdfasfdasdfasfdasfdasfdasdf",
                        style: GoogleFonts.notoSans(fontSize: 14, height: 1.57),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ));
}
