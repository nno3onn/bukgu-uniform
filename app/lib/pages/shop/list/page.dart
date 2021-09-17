import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/configs/api/networkHandler.dart';
import 'package:schooluniform/configs/api/routes.dart';

import 'package:schooluniform/configs/routes.dart';
import 'package:schooluniform/constants/theme.dart';
import 'package:schooluniform/pages/shop/list/types/pageArg.dart';
import 'package:schooluniform/pages/shop/list/types/clothFilterData.dart';

import 'package:schooluniform/components/header.dart';
import 'package:schooluniform/components/loading.dart';
import 'package:schooluniform/pages/shop/show/page.dart';

class ShopListPage extends StatefulWidget {
  @override
  ShopListPageState createState() => ShopListPageState();
}

class ShopListPageState extends State<ShopListPage> {
  var controller = ScrollController();

  String filterGender;
  String filterSeason;
  List filterClothType = [];

  bool loading = true;
  var list = [];

  var lastDoc;

  bool infiniteScrollRunnig = false;

  void request() async {
    try {
      ShopListPageArg arg = ModalRoute.of(context).settings.arguments;
      var gender = '';
      var season = '';
      if (filterGender != null && filterGender != '') {
        gender = '&gender=$filterGender';
      }
      if (filterSeason != null && filterSeason != '') {
        season = '&season=$filterSeason';
      }

      print(filterClothType);
      List<Future<dynamic>> futures = [
        NetworkHandler().get(
            '${UniformApiRoutes.LIST}?school=${arg.schoolName}&status=교복보유중&clothType=${filterClothType.toString()}' +
                gender +
                season),
      ];

      var res = await Future.wait(futures);
      List l = [];
      var _data;

      if (res[0]['data'] != null) {
        _data = res[0]['data'];

        for (var doc in _data) l.add(doc);

        setState(() {
          loading = false;
          list = l;
          if (_data.length > 0) {
            lastDoc = _data[_data.length - 1];
          }
        });
      } else {
        setState(() {
          loading = false;
          list = l;
        });
      }
      list = l;
    } catch (err) {
      print(err);
    }
  }

  void handleGenderFilter() async {
    if (filterGender != null) {
      setState(() {
        filterGender = null;
        loading = true;
      });
      request();
    } else {
      var res =
          await Navigator.of(context).pushNamed(Routes.shopListGenderFilterUrl);
      if (res != null) {
        setState(() {
          filterGender = res;
          filterSeason = null;
          filterClothType = [];
          loading = true;
        });
        request();
      }
    }
  }

  void handleClothFilter() async {
    if (filterClothType.length != 0) {
      setState(() {
        filterSeason = null;
        filterClothType = [];
        loading = true;
      });
      request();
    } else {
      var res =
          await Navigator.of(context).pushNamed(Routes.shopListClothFilterUrl);
      ShopListClothFilterData d = res;
      if (d.clothType != null && d.clothType.length != 0) {
        setState(() {
          filterSeason = d.season;
          filterClothType = d.clothType;
          loading = true;
        });
        request();
      }
    }
  }

  scrollListener() async {
    var triggerFetchMoreSize = 0.9 * controller.position.maxScrollExtent;

    if (controller.position.pixels > triggerFetchMoreSize) {
      if (!infiniteScrollRunnig && lastDoc != null) {
        setState(() {
          infiniteScrollRunnig = true;
        });

        try {
          ShopListPageArg arg = ModalRoute.of(context).settings.arguments;

          // var ref;
          // var ref = collectionUniforms
          //     .where("filter-school", isEqualTo: arg.schoolName)
          //     .where("status", isEqualTo: "교복보유중");

          // if (filterGender != null)
          //   ref = ref.where("filter-gender", isEqualTo: filterGender);
          // if (filterSeason != null)
          //   ref = ref.where("filter-season", isEqualTo: filterSeason);
          // if (filterClothType.length != 0)
          //   ref = ref.where("filter-clothType",
          //       arrayContainsAny: filterClothType);

          // var querySnapshot =
          //     await ref.startAfterDocument(lastDoc).limit(8).get();
          // var l = [];
          // for (var doc in querySnapshot.docs)
          //   l.add({"id": doc.id, ...doc.data()});
          setState(() {
            infiniteScrollRunnig = false;
            // list = list + l;
            // if (querySnapshot.docs.length > 0) {
            //   lastDoc = querySnapshot.docs[querySnapshot.docs.length - 1];
            // } else {
            //   lastDoc = null;
            // }
          });
        } catch (err) {
          print(err);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 100), () {
      request();
    });

    controller..addListener(scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(scrollListener);
    super.dispose();
  }

  Widget card(data) {
    String title = "${data["filter-gender"]} / ${data["filter-season"]} - ";
    List clothes = [];
    for (var uniform in data["uniforms"]) {
      title += "${uniform["clothType"]} (사이즈: ${uniform["size"]}), ";
    }

    if (data["filter-clothType"].indexOf("자켓") != -1) clothes.add("jacket");
    if (data["filter-clothType"].indexOf("셔츠") != -1)
      clothes.add("shirts-long");
    if (data["filter-clothType"].indexOf("상의") != -1)
      clothes.add(data["filter-season"] == "체육복" ? "jersey" : "shirts-short");
    if (data["filter-clothType"].indexOf("바지") != -1) clothes.add("pants");
    if (data["filter-clothType"].indexOf("하의") != -1) clothes.add("pants");
    if (data["filter-clothType"].indexOf("치마") != -1) clothes.add("skirts");
    if (data["filter-clothType"].indexOf("넥타이") != -1) clothes.add("necktie");
    if (data["filter-clothType"].indexOf("조끼") != -1) clothes.add("vest");

    if (clothes.length > 4) {
      clothes.removeRange(4, clothes.length);
      clothes.add("plus-extra");
    }

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(Routes.shopShowUrl,
          arguments: ShopUniformShowArg(data: data)),
      child: Column(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width / 2),
            height: (MediaQuery.of(context).size.width / 2),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkHandler().getImage(data["images"][0]),
                    fit: BoxFit.cover)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 12),
                width: (MediaQuery.of(context).size.width / 2) - 24,
                child: Text(
                  title,
                  style: GoogleFonts.notoSans(
                      fontSize: 14, height: 1.57, color: Color(0xff444444)),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var t in clothes)
                    t != "plus-extra"
                        ? Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: grey2,
                            ),
                            child: Image(
                              image: AssetImage("assets/icon/$t-grey.png"),
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image(
                              image: AssetImage(
                                "assets/icon/$t-grey.png",
                              ),
                              width: 8,
                              height: 8,
                            ),
                          )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ShopListPageArg arg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Header(
        border: false,
        popButton: true,
        title: Text(
          arg.schoolName,
          style: GoogleFonts.notoSans(fontSize: 14, color: Colors.black),
        ),
      ),
      body: loading
          ? LoadingPage()
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: handleGenderFilter,
                          child: filterGender == null
                              ? Container(
                                  color: grey2,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  height: 28,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "성별 선택",
                                    style: GoogleFonts.notoSans(
                                        fontSize: 12, color: Color(0xff444444)),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    gradient: gradSig,
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  height: 28,
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Text(
                                        filterGender,
                                        style: GoogleFonts.notoSans(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 4),
                                      ),
                                      Image(
                                        width: 12,
                                        height: 12,
                                        image: AssetImage(
                                            "assets/icon/close-white.png"),
                                      )
                                    ],
                                  ))),
                      Container(
                        margin: EdgeInsets.only(right: 16),
                      ),
                      GestureDetector(
                        onTap: handleClothFilter,
                        child: filterSeason == null
                            ? Container(
                                color: grey2,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: 28,
                                alignment: Alignment.center,
                                child: Text(
                                  "카테고리 선택",
                                  style: GoogleFonts.notoSans(
                                      fontSize: 12, color: Color(0xff444444)),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  gradient: gradSig,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: 28,
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Text(
                                      filterClothType.length == 0
                                          ? "카테고리 선택"
                                          : "$filterSeason - ${filterClothType.join(",")}",
                                      style: GoogleFonts.notoSans(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 4),
                                    ),
                                    Image(
                                      width: 12,
                                      height: 12,
                                      image: AssetImage(
                                          "assets/icon/close-white.png"),
                                    )
                                  ],
                                )),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: list.length == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image:
                                    AssetImage("assets/img/bookie-parking.png"),
                                width: 100,
                                height: 100),
                            Container(
                              margin: EdgeInsets.only(top: 8, bottom: 100),
                              child: Text(
                                "조건에 맞는 교복이 없습니다",
                                style: GoogleFonts.notoSans(
                                    fontSize: 14, color: Color(0xff444444)),
                              ),
                            )
                          ],
                        )
                      : GridView.count(
                          controller: controller,
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          childAspectRatio: (MediaQuery.of(context).size.width /
                                  2) /
                              ((MediaQuery.of(context).size.width / 2) + 116),
                          children: [
                              for (var d in list) card(d),
                            ]),
                )

                // Flexible(
                //     child: ListView(
                //   children: [
                //     Container(
                //       color: Colors.red,
                //     )
                //   ],
                // ))
              ],
            ),
    );
  }
}
