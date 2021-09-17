import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import 'package:schooluniform/configs/data.dart';
import 'package:schooluniform/constants/theme.dart';

import 'package:schooluniform/components/header2.dart';

class DonateStep1_1 extends StatefulWidget {
  @override
  DonateStep1_1State createState() => DonateStep1_1State();
}

class DonateStep1_1State extends State<DonateStep1_1>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Header2(
        border: false,
        popButton: true,
        title: Text(
          "학교 선택",
          style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                width: 1,
                color: grey2,
              ),
            )),
            child: TabBar(
              indicatorColor: colorSig1,
              labelColor: colorSig1,
              labelStyle: GoogleFonts.notoSans(
                  fontSize: 14, fontWeight: FontWeight.bold),
              unselectedLabelColor: Color(0x80000000),
              unselectedLabelStyle: TextStyle(fontSize: 14),
              controller: _tabController,
              tabs: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "중학교",
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "고등학교",
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    for (var i in middleSchools)
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(i),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 48,
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            i,
                            style: GoogleFonts.notoSans(fontSize: 14),
                          ),
                        ),
                      )
                  ],
                ),
                ListView(
                  children: [
                    for (var i in highSchools)
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(i),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 48,
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            i,
                            style: GoogleFonts.notoSans(fontSize: 14),
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
