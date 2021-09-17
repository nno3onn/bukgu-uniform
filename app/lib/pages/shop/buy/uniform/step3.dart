import 'dart:io';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:schooluniform/configs/api/networkHandler.dart';
import 'package:schooluniform/configs/api/routes.dart';
import 'package:schooluniform/configs/routes.dart';
import 'package:schooluniform/configs/stores.dart';
import 'package:schooluniform/constants/theme.dart';

import 'package:schooluniform/components/header.dart';
import 'package:schooluniform/components/loading.dart';
import 'package:schooluniform/pages/shop/buy/uniform/widgets/alarmModal.dart';

class ShopUniformInputData {
  ShopUniformInputData(
      {this.code,
      this.deliveryType,
      this.certFront,
      this.certBack,
      this.certName,
      this.certBirth,
      this.certSchool});

  final String code;
  final String deliveryType;
  final PickedFile certFront;
  final PickedFile certBack;
  final String certName;
  final String certBirth;
  final String certSchool;
}

class ShopStep3 extends StatefulWidget {
  @override
  ShopStep3State createState() => ShopStep3State();
}

class ShopStep3State extends State<ShopStep3> {
  bool loading = false;

  String name;
  TextEditingController nameController = TextEditingController();
  String phone;
  String address;
  bool checkPolicy = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      ShopUniformInputData d = ModalRoute.of(context).settings.arguments;
      setState(() {
        print(d.certName);
        nameController.text = d.certName;
        name = d.certName;
      });
    });
  }

  togglePolicy() {
    setState(() {
      checkPolicy = !checkPolicy;
    });
  }

  handleUpload() async {
    try {
      setState(() {
        loading = true;
      });

      final prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString('userId');
      ShopUniformInputData d = ModalRoute.of(context).settings.arguments;

      bool hasCertImage = d.certFront != null && d.certBack != null;

      var images;
      if (hasCertImage) {
        List<Future<dynamic>> imageFutures = [
          NetworkHandler().putImage(
              filePath: File(d.certFront.path).path, uniformId: d.code),
          NetworkHandler().putImage(
              filePath: File(d.certBack.path).path, uniformId: d.code),
        ];

        images = await Future.wait(imageFutures);
      }

      List<Future<dynamic>> futures = [
        NetworkHandler().get('${UniformApiRoutes.GET}?uniformId=${d.code}'),
        NetworkHandler().get('${UserLogsApiRoutes.PURCHASE_LIST}'),
      ];

      var res = await Future.wait(futures);
      var data = res[0]['data'];

      if (data != null) {
        var schoolLevel;
        if (data["filter-school"].indexOf("고등") == -1) {
          schoolLevel = "middleSchools";
        } else {
          schoolLevel = "highSchools";
        }

        var commonUpdateInfo = {
          "totalStock": -1,
          "totalBeforeShop": 1,
          "totalSchool": [schoolLevel, data["filter-school"], "totalStock", -1],
        };

        var log = {
          "title": data["uniforms"].length - 1 == 0
              ? "${data["filter-school"]} · ${data["filter-gender"]} · ${data["uniforms"][0]["clothType"]}"
              : "${data["filter-school"]} · ${data["filter-gender"]} · ${data["uniforms"][0]["clothType"]} 외 ${data["uniforms"].length - 1}",
          "uniformId": d.code,
          "status": "구매승인요청",
          "showStatus": "구매승인요청",
          "thumbnail": data["images"][0],
        };

        final int now = DateTime.now().millisecondsSinceEpoch;

        var uniform = await NetworkHandler()
            .get('${UniformApiRoutes.GET}?uniformId=${d.code}');

        var uniformUpdateInfo = {
          "receiverUid": uid,
          "receiverName": name,
          "receiverPhone": phone,
          "receiverAddress": address,
          "receiverDeliveryType": d.deliveryType,
          "receiverCert": hasCertImage ? [images[0], images[1]] : [],
          "receiverBirth": d.certBirth,
          "receiverSchool": d.certSchool,
          "status": "구매승인요청",
          "dateShop": now,
          "uniforms":
              uniform['data'] != null ? uniform['data']['uniforms'] : [],
          "season":
              uniform['data'] != null ? uniform['data']['"filter-season"'] : "",
          "gender":
              uniform['data'] != null ? uniform['data']['filter-gender'] : "",
        };

        await Future.wait([
          NetworkHandler().put(
              '${UniformApiRoutes.REQUEST_PURCHASE}?uniformId=${d.code}',
              uniformUpdateInfo),
          NetworkHandler().post('${InfoApiRoutes.UPDATE}', commonUpdateInfo),
          NetworkHandler().post('${UserLogsApiRoutes.PURCHASE_CREATE}', log),
        ]);

        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.userPurchaseUniformUrl,
            (route) => route.settings.name == Routes.homeUrl);
        alarmModal(context: context);
      }

      setState(() {
        loading = false;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    ShopUniformInputData d = ModalRoute.of(context).settings.arguments;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: Header(
            title: Text("구매하기 / 구매자정보",
                style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black)),
            popButton: true,
            border: true,
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 42),
                child: Text(
                  "구매자 정보를 입력해주세요",
                  style: GoogleFonts.notoSans(
                      fontSize: 24, fontWeight: FontWeight.w300, height: 1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Text(
                  "이름",
                  style: GoogleFonts.notoSans(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration:
                      BoxDecoration(border: Border.all(width: 1, color: grey3)),
                  child: TextField(
                    controller: nameController,
                    onChanged: (text) {
                      setState(() {
                        name = text;
                      });
                    },
                    cursorColor: colorSig1,
                    keyboardType: TextInputType.text,
                    decoration: deco("구매자 이름을 적어주세요"),
                    maxLength: 10,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Text(
                  "전화번호",
                  style: GoogleFonts.notoSans(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration:
                      BoxDecoration(border: Border.all(width: 1, color: grey3)),
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        phone = text;
                      });
                    },
                    cursorColor: colorSig1,
                    keyboardType: TextInputType.phone,
                    decoration: deco("- 생략"),
                    maxLength: 11,
                  ),
                ),
              ),
              d.deliveryType == "배송 요청"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "주소",
                            style: GoogleFonts.notoSans(fontSize: 12),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: grey3)),
                            child: TextField(
                              onChanged: (text) {
                                setState(() {
                                  address = text;
                                });
                              },
                              cursorColor: colorSig1,
                              keyboardType: TextInputType.streetAddress,
                              decoration: deco("배송을 요청할 주소를 입력해주세요"),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: togglePolicy,
                      child: Container(
                        color: Colors.transparent,
                        child: Row(children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(checkPolicy
                                        ? "assets/icon/checkbox-active.png"
                                        : "assets/icon/checkbox-inactive.png"))),
                          ),
                          Text(
                            "개인정보수집 및 이용 동의",
                            style: GoogleFonts.notoSans(fontSize: 14),
                          )
                        ]),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushNamed(Routes.policyUrl),
                      child: Text(
                        "전문보기",
                        style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: colorSig2,
                            decoration: TextDecoration.underline,
                            height: 1,
                            decorationColor: colorSig2),
                      ),
                    )
                  ],
                ),
              ),
              (name == null || name.length == 0) ||
                      (phone == null || phone.length != 11) ||
                      (d.deliveryType == "배송 요청" &&
                          (address == null || address.length == 0)) ||
                      !checkPolicy
                  ? Container(
                      margin: EdgeInsets.only(top: 24),
                      child: GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 32,
                          height: 52,
                          decoration: BoxDecoration(
                              color: grey6,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Text(
                            "구매하기 (무료)",
                            style: GoogleFonts.notoSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ))
                  : Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 24),
                      child: GestureDetector(
                        onTap: handleUpload,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 32,
                          height: 52,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              gradient: gradSig,
                              boxShadow: [shadowSig]),
                          child: Text(
                            "구매하기 - 무료",
                            style: GoogleFonts.notoSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ))
            ],
          ),
        ),
        loading ? LoadingPage() : Container(),
      ],
    );
  }
}
