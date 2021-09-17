import "dart:io";
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:schooluniform/configs/routes.dart';
import 'package:schooluniform/constants/theme.dart';

import 'package:schooluniform/components/header.dart';
import 'package:schooluniform/pages/shop/buy/uniform/step3.dart';

class ShopStep1 extends StatefulWidget {
  @override
  ShopStep1State createState() => ShopStep1State();
}

class ShopStep1State extends State<ShopStep1> {
  var imageFront;
  var imageBack;
  String certName;
  String certSchool;
  String certBirth;
  dynamic step = 1;

  void handleStep2(v) {
    setState(() {
      step = v;
    });
  }

  final picker = ImagePicker();
  ScrollController _controller = ScrollController();

  addImage(type) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxHeight: 600, maxWidth: 600);
    if (pickedFile != null) {
      setState(() {
        if (type == "front") imageFront = pickedFile;
        if (type == "back") imageBack = pickedFile;
        Future.delayed(Duration(milliseconds: 300), () {
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        });
      });
    }
  }

  removeImage(type) {
    setState(() {
      if (type == "front") imageFront = null;
      if (type == "back") imageBack = null;
    });
  }

  handleImageChange(type) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxHeight: 600, maxWidth: 600);
    if (pickedFile != null) {
      setState(() {
        if (type == "front") imageFront = pickedFile;
        if (type == "back") imageBack = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var code = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: step == 1 ? grey1 : Colors.white,
        appBar: Header(
          title: Text("구매하기 / 학생증등록",
              style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black)),
          popButton: true,
          border: true,
        ),
        body: step == 1
            ? ListView(
                padding: EdgeInsets.symmetric(vertical: 10),
                children: [
                  GestureDetector(
                    onTap: () => handleStep2("입학"),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "학생증이 없습니다 (올해 입학합니다)",
                        style: GoogleFonts.notoSans(fontSize: 14),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => handleStep2("재학"),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "학생증이 있습니다 (이미 재학중입니다)",
                        style: GoogleFonts.notoSans(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              )
            : step == "재학"
                ? ListView(
                    controller: _controller,
                    padding: EdgeInsets.symmetric(vertical: 32),
                    children: [
                      Container(
                          margin:
                              EdgeInsets.only(bottom: 24, left: 16, right: 16),
                          padding: EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: grey2, width: 1))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "학생증 앞면",
                                style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff444444)),
                              ),
                              imageFront == null
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.only(top: 12),
                                      width: MediaQuery.of(context).size.width -
                                          32,
                                      height:
                                          MediaQuery.of(context).size.width -
                                              32,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(
                                                File(imageFront.path)),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                              Container(
                                margin: EdgeInsets.only(top: 12),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (imageFront == null)
                                      addImage("front");
                                    else
                                      handleImageChange("front");
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: grey2,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Text(
                                      imageFront == null
                                          ? "학생증 앞면 업로드"
                                          : "사진변경",
                                      style: GoogleFonts.notoSans(fontSize: 14),
                                    ),
                                  ))
                            ],
                          )),
                      Container(
                          margin:
                              EdgeInsets.only(bottom: 24, left: 16, right: 16),
                          padding: EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: grey2, width: 1))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "학생증 뒷면",
                                style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff444444)),
                              ),
                              imageBack == null
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.only(top: 12),
                                      width: MediaQuery.of(context).size.width -
                                          32,
                                      height:
                                          MediaQuery.of(context).size.width -
                                              32,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                FileImage(File(imageBack.path)),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                              Container(
                                margin: EdgeInsets.only(top: 12),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (imageBack == null)
                                      addImage("back");
                                    else
                                      handleImageChange("back");
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: grey2,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Text(
                                      imageBack == null ? "학생증 뒷면 업로드" : "사진변경",
                                      style: GoogleFonts.notoSans(fontSize: 14),
                                    ),
                                  ))
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          (imageFront == null || imageBack == null)
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 24),
                                  child: GestureDetector(
                                    child: Container(
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: grey6),
                                      padding: EdgeInsets.all(18),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/icon/arrow-right-white.png"),
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                  ))
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 24),
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(Routes.shopStep2Url,
                                            arguments: ShopUniformInputData(
                                                code: code,
                                                certFront: imageFront,
                                                certBack: imageBack)),
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
                      )
                    ],
                  )
                : ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    children: [
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: grey3)),
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                certName = text;
                              });
                            },
                            cursorColor: colorSig1,
                            keyboardType: TextInputType.text,
                            decoration: deco("입학 예정자 이름을 적어주세요"),
                            maxLength: 10,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "생일",
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
                                certBirth = text;
                              });
                            },
                            cursorColor: colorSig1,
                            keyboardType: TextInputType.phone,
                            decoration: deco("예: 20050101"),
                            maxLength: 8,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "입학 예정 학교",
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
                                certSchool = text;
                              });
                            },
                            cursorColor: colorSig1,
                            keyboardType: TextInputType.streetAddress,
                            decoration: deco("입학예정학교를 입력해주세요"),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 24),
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
                          (certName == null ||
                                  certBirth == null ||
                                  certBirth.length != 8 ||
                                  certSchool == null)
                              ? Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 24),
                                  child: GestureDetector(
                                    child: Container(
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: grey6),
                                      padding: EdgeInsets.all(18),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/icon/arrow-right-white.png"),
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                  ))
                              : Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 24),
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(Routes.shopStep2Url,
                                            arguments: ShopUniformInputData(
                                                code: code,
                                                certName: certName,
                                                certBirth: certBirth,
                                                certSchool: certSchool,
                                                certFront: imageFront,
                                                certBack: imageBack)),
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
                    ],
                  ));
  }
}
