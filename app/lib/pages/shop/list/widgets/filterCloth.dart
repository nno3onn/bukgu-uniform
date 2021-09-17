import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/components/header2.dart';
import 'package:schooluniform/constants/theme.dart';
import 'package:schooluniform/pages/shop/list/types/clothFilterData.dart';

class ShopListClothFilter extends StatefulWidget {
  @override
  ShopListClothFilterState createState() => ShopListClothFilterState();
}

class ShopListClothFilterState extends State<ShopListClothFilter> {
  int step = 1;
  String season;
  List clothType = [];

  void handleStep2(s) {
    setState(() {
      season = s;
      step = 2;
    });
  }

  void toggleClothType(v) {
    if (clothType.indexOf(v) == -1)
      setState(() {
        clothType.add('"$v"');
      });
    else
      setState(() {
        clothType.remove('"$v"');
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: grey1,
        appBar: Header2(
          popButton: true,
          title: Text(
            "분류 선택",
            style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black),
          ),
          border: true,
        ),
        body: Stack(
          children: [
            step == 1
                ? ListView(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    children: [
                      GestureDetector(
                        onTap: () => handleStep2("동복"),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "동복",
                            style: GoogleFonts.notoSans(fontSize: 14),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => handleStep2("하복"),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "하복",
                            style: GoogleFonts.notoSans(fontSize: 14),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => handleStep2("생활복"),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "생활복",
                            style: GoogleFonts.notoSans(fontSize: 14),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => handleStep2("체육복"),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "체육복",
                            style: GoogleFonts.notoSans(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    children: [
                      season == "동복"
                          ? GestureDetector(
                              onTap: () => toggleClothType("자켓"),
                              child: Container(
                                  color: clothType.indexOf("자켓") == -1
                                      ? Colors.white
                                      : Color(0x07ff4a68),
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 8),
                                        child: Image(
                                          width: 36,
                                          height: 36,
                                          image: AssetImage(
                                              "assets/icon/${clothType.indexOf("자켓") == -1 ? "jacket-light-grey" : "jacket-pink"}.png"),
                                        ),
                                      ),
                                      Text(
                                        "자켓",
                                        style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color: clothType.indexOf("자켓") == -1
                                                ? Colors.black
                                                : colorSig2),
                                      ),
                                    ],
                                  )),
                            )
                          : Container(),
                      season == "동복"
                          ? GestureDetector(
                              onTap: () => toggleClothType("넥타이"),
                              child: Container(
                                  color: clothType.indexOf("넥타이") == -1
                                      ? Colors.white
                                      : Color(0x07ff4a68),
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 8),
                                        child: Image(
                                          width: 36,
                                          height: 36,
                                          image: AssetImage(
                                              "assets/icon/${clothType.indexOf("넥타이") == -1 ? "necktie-light-grey" : "necktie-pink"}.png"),
                                        ),
                                      ),
                                      Text(
                                        "넥타이",
                                        style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color:
                                                clothType.indexOf("넥타이") == -1
                                                    ? Colors.black
                                                    : colorSig2),
                                      ),
                                    ],
                                  )),
                            )
                          : Container(),
                      season == "동복"
                          ? GestureDetector(
                              onTap: () => toggleClothType("조끼"),
                              child: Container(
                                  color: clothType.indexOf("조끼") == -1
                                      ? Colors.white
                                      : Color(0x07ff4a68),
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 8),
                                        child: Image(
                                          width: 36,
                                          height: 36,
                                          image: AssetImage(
                                              "assets/icon/${clothType.indexOf("조끼") == -1 ? "vest-light-grey" : "vest-pink"}.png"),
                                        ),
                                      ),
                                      Text(
                                        "조끼",
                                        style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color: clothType.indexOf("조끼") == -1
                                                ? Colors.black
                                                : colorSig2),
                                      ),
                                    ],
                                  )),
                            )
                          : Container(),
                      season == "동복"
                          ? GestureDetector(
                              onTap: () => toggleClothType("셔츠"),
                              child: Container(
                                  color: clothType.indexOf("셔츠") == -1
                                      ? Colors.white
                                      : Color(0x07ff4a68),
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 8),
                                        child: Image(
                                          width: 36,
                                          height: 36,
                                          image: AssetImage(
                                              "assets/icon/${clothType.indexOf("셔츠") == -1 ? "shirts-long-light-grey" : "shirts-long-pink"}.png"),
                                        ),
                                      ),
                                      Text(
                                        "셔츠",
                                        style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color: clothType.indexOf("셔츠") == -1
                                                ? Colors.black
                                                : colorSig2),
                                      ),
                                    ],
                                  )),
                            )
                          : Container(),
                      season == "하복"
                          ? GestureDetector(
                              onTap: () => toggleClothType("셔츠"),
                              child: Container(
                                  color: clothType.indexOf("셔츠") == -1
                                      ? Colors.white
                                      : Color(0x07ff4a68),
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 8),
                                        child: Image(
                                          width: 36,
                                          height: 36,
                                          image: AssetImage(
                                              "assets/icon/${clothType.indexOf("셔츠") == -1 ? "shirts-short-light-grey" : "shirts-short-pink"}.png"),
                                        ),
                                      ),
                                      Text(
                                        "셔츠",
                                        style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color: clothType.indexOf("셔츠") == -1
                                                ? Colors.black
                                                : colorSig2),
                                      ),
                                    ],
                                  )),
                            )
                          : Container(),
                      season == "생활복"
                          ? GestureDetector(
                              onTap: () => toggleClothType("상의"),
                              child: Container(
                                  color: clothType.indexOf("상의") == -1
                                      ? Colors.white
                                      : Color(0x07ff4a68),
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 8),
                                        child: Image(
                                          width: 36,
                                          height: 36,
                                          image: AssetImage(
                                              "assets/icon/${clothType.indexOf("상의") == -1 ? "tshirts-light-grey" : "tshirts-pink"}.png"),
                                        ),
                                      ),
                                      Text(
                                        "상의",
                                        style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color: clothType.indexOf("상의") == -1
                                                ? Colors.black
                                                : colorSig2),
                                      ),
                                    ],
                                  )),
                            )
                          : Container(),
                      season == "체육복"
                          ? GestureDetector(
                              onTap: () => toggleClothType("상의"),
                              child: Container(
                                  color: clothType.indexOf("상의") == -1
                                      ? Colors.white
                                      : Color(0x07ff4a68),
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 8),
                                        child: Image(
                                          width: 36,
                                          height: 36,
                                          image: AssetImage(
                                              "assets/icon/${clothType.indexOf("상의") == -1 ? "jersey-light-grey" : "jersey-pink"}.png"),
                                        ),
                                      ),
                                      Text(
                                        "상의",
                                        style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color: clothType.indexOf("상의") == -1
                                                ? Colors.black
                                                : colorSig2),
                                      ),
                                    ],
                                  )),
                            )
                          : Container(),
                      GestureDetector(
                        onTap: () => toggleClothType(
                            season == "동복" || season == "하복" ? "바지" : "하의"),
                        child: Container(
                            color: clothType.indexOf(
                                        season == "동복" || season == "하복"
                                            ? "바지"
                                            : "하의") ==
                                    -1
                                ? Colors.white
                                : Color(0x07ff4a68),
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: Image(
                                    width: 36,
                                    height: 36,
                                    image: AssetImage(
                                        "assets/icon/${clothType.indexOf(season == "동복" || season == "하복" ? "바지" : "하의") == -1 ? "pants-light-grey" : "pants-pink"}.png"),
                                  ),
                                ),
                                Text(
                                  season == "동복" || season == "하복"
                                      ? "바지"
                                      : "하의",
                                  style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      color: clothType.indexOf(season == "동복" ||
                                                      season == "하복"
                                                  ? "바지"
                                                  : "하의") ==
                                              -1
                                          ? Colors.black
                                          : colorSig2),
                                ),
                              ],
                            )),
                      ),
                      season == "동복"
                          ? GestureDetector(
                              onTap: () => toggleClothType("치마"),
                              child: Container(
                                  color: clothType.indexOf("치마") == -1
                                      ? Colors.white
                                      : Color(0x07ff4a68),
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 8),
                                        child: Image(
                                          width: 36,
                                          height: 36,
                                          image: AssetImage(
                                              "assets/icon/${clothType.indexOf("치마") == -1 ? "skirts-light-grey" : "skirts-pink"}.png"),
                                        ),
                                      ),
                                      Text(
                                        "치마",
                                        style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color: clothType.indexOf("치마") == -1
                                                ? Colors.black
                                                : colorSig2),
                                      ),
                                    ],
                                  )),
                            )
                          : Container(),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 24, left: 16),
                        child: GestureDetector(
                          onTap: () => setState(() {
                            step = 1;
                          }),
                          child: Container(
                            width: 52,
                            height: 52,
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: Image(
                              image: AssetImage(
                                  "assets/icon/arrow-left-white.png"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            clothType.length != 0
                ? Positioned(
                    bottom: 0,
                    child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(
                            ShopListClothFilterData(
                                season: season, clothType: clothType)),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: gradSig,
                          ),
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).padding.bottom),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 52,
                            child: Text(
                              "총 ${clothType.length}개 항목 검색",
                              style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                  )
                : Container()
          ],
        ));
  }
}
