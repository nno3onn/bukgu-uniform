import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:schooluniform/constants/theme.dart';
import 'package:schooluniform/configs/routes.dart';
import 'package:schooluniform/configs/stores.dart';

import 'package:schooluniform/components/header.dart';
import 'package:schooluniform/pages/shop/buy/uniform/step3.dart';

class ShopStep2 extends StatefulWidget {
  @override
  ShopStep2State createState() => ShopStep2State();
}

class ShopStep2State extends State<ShopStep2> {
  String deliveryType;

  handleDeliveryType(String g) {
    setState(() {
      deliveryType = g;
    });
  }

  @override
  Widget build(BuildContext context) {
    ShopUniformInputData d = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: Header(
          title: Text("구매하기 / 수령방법",
              style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black)),
          popButton: true,
          border: true,
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "교복수령방식을 선택해주세요",
                      style: GoogleFonts.notoSans(
                          fontSize: 24, fontWeight: FontWeight.w300, height: 1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => handleDeliveryType("봉사센터 방문"),
                    child: Container(
                      height: 46,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 18,
                            height: 18,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: deliveryType == "봉사센터 방문"
                                        ? Colors.black
                                        : grey6)),
                            child: deliveryType == "봉사센터 방문"
                                ? Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black),
                                  )
                                : Container(),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "북구자원봉사센터 방문",
                                    style: GoogleFonts.notoSans(
                                        fontSize: 14, height: 1),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 4),
                                    child: GestureDetector(
                                      onTap: () => launch(
                                          infoStore.localInfo["centerAddress"]),
                                      child: Text(
                                        "위치보기",
                                        style: GoogleFonts.notoSans(
                                            color: colorSig1,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                              ),
                              Text(
                                "구매자가 센터를 직접 방문하여 교복을 수령합니다",
                                style: GoogleFonts.notoSans(
                                    fontSize: 12,
                                    color: Color(0xff666666),
                                    height: 1),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                  ),
                  GestureDetector(
                    onTap: () => handleDeliveryType("배송 요청"),
                    child: Container(
                      height: 46,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 18,
                            height: 18,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: deliveryType == "배송 요청"
                                        ? Colors.black
                                        : grey6)),
                            child: deliveryType == "배송 요청"
                                ? Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black),
                                  )
                                : Container(),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "배송 요청",
                                style: GoogleFonts.notoSans(
                                    fontSize: 14, height: 1),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                              ),
                              Text(
                                "입력하신 주소지로 택배(착불)가 발송됩니다",
                                style: GoogleFonts.notoSans(
                                    fontSize: 12,
                                    color: Color(0xff666666),
                                    height: 1),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  deliveryType == null
                      ? Container()
                      : Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 24),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(
                                Routes.shopStep3Url,
                                arguments: ShopUniformInputData(
                                    code: d.code,
                                    certFront: d.certFront,
                                    certBack: d.certBack,
                                    certName: d.certName,
                                    certBirth: d.certBirth,
                                    certSchool: d.certSchool,
                                    deliveryType: deliveryType)),
                            child: Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: gradSig,
                                  boxShadow: [shadowSig]),
                              padding: EdgeInsets.all(18),
                              child: Image(
                                image: AssetImage(
                                    "assets/icon/arrow-right-white.png"),
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ))
                ],
              ),
            )
          ],
        ));
  }
}
