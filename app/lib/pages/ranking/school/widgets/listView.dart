import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/configs/stores.dart';
import 'package:schooluniform/constants/theme.dart';
import 'package:schooluniform/utils/getRankingSchool.dart';

class RankingSchoolListViewWidget extends StatelessWidget {
  final String ref;
  RankingSchoolListViewWidget({this.ref});
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.only(top: 36, bottom: 36),
        children: [
        for (var school in getRankingSchool(
            infoStore.localInfo[ref]))
          Container(
              margin: EdgeInsets.only(bottom: 36),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${school["rank"] < 10 ? 0 : ""}${school["rank"]}",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: colorSig2),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text(
                              "${school["school"]}",
                              style: GoogleFonts.notoSans(
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("${school["total"]}",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                              )),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        width: MediaQuery.of(context)
                                .size
                                .width -
                            32,
                        height: 8,
                        decoration: BoxDecoration(
                          color: grey2,
                          borderRadius: BorderRadius.all(
                              Radius.circular(2)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        width: school["total"] == 0
                            ? 0
                            : (MediaQuery.of(context)
                                        .size
                                        .width -
                                    32) *
                                (school["total"] /
                                    school["maxValue"]),
                        height: 8,
                        decoration: BoxDecoration(
                          gradient: gradSig,
                          borderRadius: BorderRadius.all(
                              Radius.circular(2)),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
      ],
    );
  }
}