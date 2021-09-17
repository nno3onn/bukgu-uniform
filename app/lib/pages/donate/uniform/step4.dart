import "package:flutter/material.dart";
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:schooluniform/configs/routes.dart';
import 'package:schooluniform/configs/stores.dart';
import 'package:schooluniform/constants/theme.dart';
import 'package:schooluniform/pages/donate/uniform/types/donateInfo.dart';

import 'package:schooluniform/components/header.dart';
import 'package:schooluniform/pages/donate/uniform/widgets/selectDeliveryType.dart';

class DonateStep4 extends StatefulWidget {
  @override
  DonateStep4State createState() => DonateStep4State();
}

class DonateStep4State extends State<DonateStep4> {
  String deliveryType;

  handleDeliveryType(String g) {
    setState(() {
      deliveryType = g;
    });
  }

  @override
  Widget build(BuildContext context) {
    DonateInfo d = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: Header(
          title: Text("교복 기부하기",
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
                      "교복수거방식을 선택해주세요",
                      style: GoogleFonts.notoSans(
                          fontSize: 24, fontWeight: FontWeight.w300, height: 1),
                    ),
                  ),
                  SelectDeliveryTypeWidget(
                    deliveryType: deliveryType,
                    label: "봉사센터 방문",
                    displayLabel: "북구자원봉사센터 방문",
                    displaySecondaryLabel: "기부자가 봉사센터를 직접 방문하여 교복을 전달합니다",
                    onClick: () => handleDeliveryType("봉사센터 방문"),
                    actionButton: Observer(
                        builder: (_) => Container(
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
                            )),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                  ),
                  SelectDeliveryTypeWidget(
                    deliveryType: deliveryType,
                    label: "복지센터 방문",
                    displayLabel: "동 행정복지센터 방문",
                    displaySecondaryLabel: "기부자가 행정복지센터(북구 관내)를 방문하여 교복을 전달합니다",
                    onClick: () => handleDeliveryType("복지센터 방문"),
                    actionButton: Container(),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                  ),
                  SelectDeliveryTypeWidget(
                    deliveryType: deliveryType,
                    label: "수거 요청",
                    displayLabel: "수거 요청",
                    displaySecondaryLabel: "담당자가 요청지로(북구관내 한) 방문하여 교복을 수거합니다",
                    onClick: () => handleDeliveryType("수거 요청"),
                    actionButton: Container(),
                  ),
                  deliveryType == null
                      ? Container()
                      : Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 24),
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.of(context)
                                  .pushNamed(Routes.donateStep5Url,
                                      arguments: DonateInfo(
                                        school: d.school,
                                        gender: d.gender,
                                        season: d.season,
                                        deliveryType: deliveryType,
                                        images: d.images,
                                        uniforms: d.uniforms,
                                      ));
                            },
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
