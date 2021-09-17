import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import 'package:schooluniform/configs/routes.dart';
import 'package:schooluniform/constants/theme.dart';
import 'package:schooluniform/pages/donate/uniform/types/donateInfo.dart';
import 'package:schooluniform/pages/donate/uniform/types/donateState1_4Data.dart';
import 'package:schooluniform/pages/donate/uniform/types/uniform.dart';

import 'package:schooluniform/components/header.dart';

class DonateStep1 extends StatefulWidget {
  @override
  DonateStep1State createState() => DonateStep1State();
}

class DonateStep1State extends State<DonateStep1> {
  String school = '';
  String gender = '';
  String season = '';
  List uniforms = [];

  ScrollController _controller = ScrollController();

  addUniform(data) {
    setState(() {
      uniforms.add(Uniform(
        school: school,
        gender: gender,
        season: season,
        clothType: data.clothType,
        size: data.size,
      ));
    });
  }

  removeUniform(index) {
    setState(() {
      uniforms.removeAt(index);
    });
  }

  handleAdd() async {
    var u = await Navigator.of(context).pushNamed(Routes.donateStep1_1Url);
    if (u != null) {
      Uniform uu = u;
      if (uu.school != null &&
          uu.season != null &&
          uu.gender != null &&
          uu.clothType != null) addUniform(u);
    }
  }

  handleSchool() async {
    var res = await Navigator.of(context).pushNamed(Routes.donateStep1_1Url);
    if (res != null) {
      setState(() {
        school = res;
        uniforms = [];
      });
    }
  }

  handleGender() async {
    var res = await Navigator.of(context).pushNamed(Routes.donateStep1_2Url);
    if (res != null) {
      setState(() {
        gender = res;
        uniforms = [];
      });
    }
  }

  handleSeason() async {
    var res = await Navigator.of(context).pushNamed(Routes.donateStep1_3Url);
    if (res != null) {
      setState(() {
        season = res;
        uniforms = [];
      });
    }
  }

  handleClothType() async {
    var res = await Navigator.of(context).pushNamed(Routes.donateStep1_4Url,
        arguments: DonateState1_4InputData(season: season, gender: gender));
    if (res != null) {
      addUniform(res);
      Future.delayed(Duration(milliseconds: 300), () {
        _controller.animateTo(_controller.position.maxScrollExtent,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: Header(
          title: Text("교복 기부하기",
              style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black)),
          popButton: true,
          border: true,
        ),
        body: Stack(
          children: [
            ListView(
              controller: _controller,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 32),
                  child: Text(
                    "기부할 교복을 등록해주세요",
                    style: GoogleFonts.notoSans(
                        fontSize: 24, fontWeight: FontWeight.w300, height: 1),
                  ),
                ),
                school == ''
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          ": $school",
                          style: GoogleFonts.notoSans(fontSize: 14),
                        ),
                      ),
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: GestureDetector(
                    onTap: () => handleSchool(),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 32,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: grey2,
                      ),
                      child: Text(
                        school == '' ? "+ 학교 등록하기" : "학교 변경하기",
                        style: GoogleFonts.notoSans(fontSize: 14),
                      ),
                    ),
                  ),
                ),
                gender == ''
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          ": $gender",
                          style: GoogleFonts.notoSans(fontSize: 14),
                        ),
                      ),
                school != ''
                    ? Container(
                        margin: EdgeInsets.only(bottom: 24),
                        child: GestureDetector(
                          onTap: handleGender,
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 32,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: grey2,
                            ),
                            child: Text(
                              gender == '' ? "+ 성별 등록하기" : "성별 변경하기",
                              style: GoogleFonts.notoSans(fontSize: 14),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                season == ''
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          ": $season",
                          style: GoogleFonts.notoSans(fontSize: 14),
                        ),
                      ),
                school != '' && gender != ''
                    ? Container(
                        margin: EdgeInsets.only(bottom: 48),
                        child: GestureDetector(
                          onTap: handleSeason,
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 32,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: grey2,
                            ),
                            child: Text(
                              season == '' ? "+ 계절복 등록하기" : "계절복 변경하기",
                              style: GoogleFonts.notoSans(fontSize: 14),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                for (int i = 0; i < uniforms.length; i++)
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: grey6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                              "${uniforms[i].school} · ${uniforms[i].gender} · ${uniforms[i].season} · ${uniforms[i].clothType}"),
                        ),
                        GestureDetector(
                            onTap: () => removeUniform(i),
                            child: Container(
                              color: Colors.transparent,
                              width: 46,
                              height: 46,
                              padding: EdgeInsets.all(18),
                              child: Image(
                                image:
                                    AssetImage("assets/icon/close-small.png"),
                              ),
                            ))
                      ],
                    ),
                  ),
                school != '' && gender != '' && season != ''
                    ? Container(
                        margin: EdgeInsets.only(bottom: 80),
                        child: GestureDetector(
                          onTap: handleClothType,
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 32,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: grey2,
                            ),
                            child: Text(
                              "+ 교복 등록하기",
                              style: GoogleFonts.notoSans(fontSize: 14),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
            uniforms.length > 0
                ? Positioned(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(
                          Routes.donateStep3Url,
                          arguments: DonateInfo(
                              uniforms: uniforms,
                              school: school,
                              gender: gender,
                              season: season)),
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 52 + MediaQuery.of(context).padding.bottom,
                        decoration: BoxDecoration(
                          gradient: gradSig,
                        ),
                        child: Text(
                          "등록한 교복 기부하기",
                          style: GoogleFonts.notoSans(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    bottom: 0,
                  )
                : Container(),
          ],
        ));
  }
}
