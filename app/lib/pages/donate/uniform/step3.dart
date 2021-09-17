import 'dart:io';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:schooluniform/configs/routes.dart';
import 'package:schooluniform/constants/theme.dart';
import 'package:schooluniform/pages/donate/uniform/types/donateInfo.dart';

import 'package:schooluniform/components/header.dart';
import 'package:schooluniform/pages/donate/uniform/widgets/imageHandler.dart';

class DonateStep3 extends StatefulWidget {
  @override
  DonateStep3State createState() => DonateStep3State();
}

class DonateStep3State extends State<DonateStep3> {
  List images = [];

  final picker = ImagePicker();
  ScrollController _controller = ScrollController();

  handleImageAddFrom(type) async {
    final pickedFile = await picker.getImage(
        source: type == "camera" ? ImageSource.camera : ImageSource.gallery,
        maxHeight: 600,
        maxWidth: 600);
    if (pickedFile != null) {
      setState(() {
        images.add(pickedFile);
        Future.delayed(Duration(milliseconds: 300), () {
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          );
        });
      });
    }
    Navigator.of(context).pop();
  }

  handleImageRemove(index) {
    setState(() {
      images.removeAt(index);
      Navigator.of(context).pop();
    });
  }

  handleImageChange(index) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxHeight: 600, maxWidth: 600);
    if (pickedFile != null) {
      setState(() {
        images[index] = pickedFile;
        Navigator.of(context).pop();
      });
    }
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
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 32),
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              "기부하시려는 교복의\n사진을 업로드해주세요",
              style: GoogleFonts.notoSans(
                  fontSize: 24, fontWeight: FontWeight.w300, height: 1.5),
            ),
          ),
          Container(
            height: 80,
            child: ListView(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (int i = 0; i < images.length; i++)
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => showModal(
                          context: context,
                          label1: "사진 삭제",
                          onClickForLabel1: () => {handleImageRemove(i)},
                          label2: "사진 교체",
                          onClickForLabel2: () => {handleImageChange(i)}),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            color: grey2,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            image: DecorationImage(
                                image: FileImage(File(images[i].path)),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                images.length < 10
                    ? GestureDetector(
                        onTap: () => showModal(
                            context: context,
                            label1: "갤러리 보기",
                            onClickForLabel1: () =>
                                {handleImageAddFrom("gallery")},
                            label2: "직접 촬영",
                            onClickForLabel2: () =>
                                {handleImageAddFrom("camera")}),
                        child: Container(
                          width: 80,
                          height: 80,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color: grey2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Image(
                            image: AssetImage("assets/icon/upload.png"),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          (images.length == 0)
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
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: grey6),
                      padding: EdgeInsets.all(18),
                      child: Image(
                        image: AssetImage("assets/icon/arrow-right-white.png"),
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
                    onTap: () =>
                        Navigator.of(context).pushNamed(Routes.donateStep4Url,
                            arguments: DonateInfo(
                              school: d.school,
                              gender: d.gender,
                              season: d.season,
                              images: images,
                              uniforms: d.uniforms,
                            )),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: gradSig,
                          boxShadow: [shadowSig]),
                      padding: EdgeInsets.all(18),
                      child: Image(
                        image: AssetImage("assets/icon/arrow-right-white.png"),
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
