import "package:flutter/material.dart";
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schooluniform/components/header.dart';
import 'package:schooluniform/configs/data.dart';
import 'package:schooluniform/constants/theme.dart';

import 'package:schooluniform/pages/shop/filter/widgets/listView.dart';

class ShopFilterPage extends StatefulWidget {
  @override
  ShopFilterPageState createState() => ShopFilterPageState();
}

class ShopFilterPageState extends State<ShopFilterPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Scaffold(
            backgroundColor: Colors.white,
            appBar: Header(
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
                      ListViewWidget(data: middleSchools, ref: 'middleSchools'),
                      ListViewWidget(data: highSchools, ref: 'highSchools'),
                    ],
                  ),
                ),
              ],
            )));
  }
}
