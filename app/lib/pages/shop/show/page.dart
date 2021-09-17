import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:schooluniform/configs/api/networkHandler.dart';
import 'package:schooluniform/configs/api/routes.dart';
import 'package:schooluniform/configs/stores.dart';
import 'package:schooluniform/constants/theme.dart';

import 'package:schooluniform/pages/shop/show/widgets/addToCartModal.dart';
import 'package:schooluniform/pages/shop/show/widgets/buyNowModal.dart';

class ShopUniformShowArg {
  ShopUniformShowArg({
    this.data,
  });

  final dynamic data;
}

class ShopShowPage extends StatefulWidget {
  @override
  ShopShowPageState createState() => ShopShowPageState();
}

class ShopShowPageState extends State<ShopShowPage> {
  int thumbnailPage = 0;
  PageController thumbnailController = PageController(initialPage: 0);

  void addToCart() async {
    ShopUniformShowArg data = ModalRoute.of(context).settings.arguments;
    final prefs = await SharedPreferences.getInstance();

    var uid = prefs.getString('userId');

    addToCartModal(context: context);

    Map cartAddInfo = {"uniformId": data.data["code"]};

    Map userUpdateInfo = {
      "total": infoStore.userInfo["total"] + 1,
      "uniformCart": infoStore.userInfo["uniformCart"] + 1,
    };

    await Future.wait([
      NetworkHandler().post('${UserLogsApiRoutes.CART_ADD}', cartAddInfo),
      NetworkHandler()
          .put('${UserApiRoutes.UPDATE}?targetUid=$uid', userUpdateInfo),
    ]);

    infoStore.updateUserData("total", infoStore.userInfo["total"] + 1);
    infoStore.updateUserData(
        "uniformCart", infoStore.userInfo["uniformCart"] + 1);
  }

  void buyNow() async {
    ShopUniformShowArg data = ModalRoute.of(context).settings.arguments;
    buyNowModal(context: context, data: data);
  }

  @override
  Widget build(BuildContext context) {
    ShopUniformShowArg data = ModalRoute.of(context).settings.arguments;

    List clothes = [];

    if (data.data["filter-clothType"].indexOf("자켓") != -1)
      clothes.add("jacket");
    if (data.data["filter-clothType"].indexOf("셔츠") != -1)
      clothes.add("shirts-long");
    if (data.data["filter-clothType"].indexOf("상의") != -1)
      clothes
          .add(data.data["filter-season"] == "체육복" ? "jersey" : "shirts-short");
    if (data.data["filter-clothType"].indexOf("바지") != -1) clothes.add("pants");
    if (data.data["filter-clothType"].indexOf("하의") != -1) clothes.add("pants");
    if (data.data["filter-clothType"].indexOf("치마") != -1)
      clothes.add("skirts");
    if (data.data["filter-clothType"].indexOf("넥타이") != -1)
      clothes.add("necktie");
    if (data.data["filter-clothType"].indexOf("조끼") != -1) clothes.add("vest");

    return Scaffold(
        body: Stack(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width,
                  child: PageView(
                    controller: thumbnailController,
                    onPageChanged: (value) {
                      setState(() {
                        thumbnailPage = value;
                      });
                    },
                    children: [
                      for (var img in data.data["images"])
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkHandler().getImage(img))),
                        )
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: Color(0x80000000),
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                    child: Text(
                        "${thumbnailPage + 1} / ${data.data["images"].length}",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.white,
                        )),
                  ),
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  brightness: Brightness.dark,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Image(
                        image: AssetImage("assets/icon/show-backbutton.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 12, left: 16, right: 16),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Text(
                      "상품코드",
                      style: GoogleFonts.notoSans(
                          fontSize: 16, color: Color(0xff444444)),
                    ),
                  ),
                  Text(
                    data.data["code"],
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: Color(0xff888888)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  for (var c in clothes)
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: grey2,
                      ),
                      child: Image(
                        image: AssetImage("assets/icon/$c-grey.png"),
                      ),
                    )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 32, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Text(
                        "상품정보",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: Color(0xff444444),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                          "${data.data["uniforms"][0]["school"]} / ${data.data["uniforms"][0]["gender"]} / ${data.data["uniforms"][0]["season"]}"),
                    ),
                    for (var uniform in data.data["uniforms"])
                      Container(
                        child: Text(
                            "- ${uniform["clothType"]}: ${uniform["size"]}"),
                      ),
                  ],
                )),
          ],
        ),
        Positioned(
            bottom: 0,
            child: data.data["status"] == "교복보유중"
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).padding.bottom + 52,
                    child: Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: addToCart,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xff666666),
                                        Color(0xff444444)
                                      ]),
                                ),
                                padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).padding.bottom),
                                alignment: Alignment.center,
                                child: Text(
                                  "장바구니",
                                  style: GoogleFonts.notoSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            )),
                        Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: buyNow,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: gradSig,
                                ),
                                padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).padding.bottom),
                                alignment: Alignment.center,
                                child: Text(
                                  "구매하기 (무료)",
                                  style: GoogleFonts.notoSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            )),
                      ],
                    ),
                  )
                : Container(
                    color: grey3,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).padding.bottom + 52,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom),
                    child: Text(
                      "다른 유저가 이미 신청한 상품입니다",
                      style: GoogleFonts.notoSans(
                          fontSize: 14, color: Color(0xff444444)),
                    ),
                  )),
        Positioned(
          top: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x51000000), Color(0x00000000)])),
          ),
        ),
      ],
    ));
  }
}
