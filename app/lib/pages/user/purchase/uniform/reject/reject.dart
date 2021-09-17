import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import 'package:schooluniform/constants/theme.dart';

import 'package:schooluniform/components/header2.dart';
import 'package:schooluniform/components/loading.dart';

class UserPurchaseUniformRejectPage extends StatefulWidget {
  UserPurchaseUniformRejectPage({this.code});

  final String code;

  @override
  UserPurchaseUniformRejectPageState createState() =>
      UserPurchaseUniformRejectPageState();
}

class UserPurchaseUniformRejectPageState
    extends State<UserPurchaseUniformRejectPage> {
  bool loading = true;
  var data;

  void request() async {
    try {
      // User u = FirebaseAuth.instance.currentUser;

      // DocumentSnapshot doc = await getLogsUniformShop(u.uid).get();

      // if (doc.exists) {
      //   var d = doc.data();

      //   setState(() {
      //     data = d[widget.code];
      //     loading = false;
      //   });
      // } else {
      setState(() {
        loading = false;
      });
      // }
    } catch (err) {
      print(err);
    }
  }

  void initState() {
    super.initState();
    request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Header2(
        popButton: true,
        title: Text(
          "거절 사유 확인",
          style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black),
        ),
        border: false,
      ),
      body: loading
          ? LoadingPage()
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              children: [
                Column(
                  children: [
                    Container(
                      width: 188,
                      height: 188,
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(data["thumbnail"]),
                              fit: BoxFit.cover)),
                    ),
                    Text(data["title"],
                        style: GoogleFonts.notoSans(fontSize: 16, height: 1.5)),
                    Container(
                      margin: EdgeInsets.only(bottom: 13),
                    ),
                    Text(
                      "위 상품에 대한 구매 요청이 거절되었습니다",
                      style: GoogleFonts.notoSans(
                          fontSize: 14, height: 1.57, color: colorRejectRed),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 17, bottom: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: grey3))),
                    ),
                    Text(
                      "거절 사유",
                      style: GoogleFonts.notoSans(
                          fontSize: 14, color: Color(0xff888888)),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 13),
                    ),
                    Text(
                      data["why"],
                      style: GoogleFonts.notoSans(
                          fontSize: 14, height: 1.57, color: Color(0xff444444)),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
