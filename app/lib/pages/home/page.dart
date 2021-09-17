import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import "dart:async";
import "dart:core";
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:schooluniform/constants/theme.dart';
import 'package:schooluniform/configs/stores.dart';
import 'package:schooluniform/configs/routes.dart';
import 'package:schooluniform/utils/getMostDonateSchool.dart';
import 'package:schooluniform/utils/time/getCurrent.dart';

import 'package:schooluniform/components/header.dart';
import 'package:schooluniform/components/footer.dart';
import 'package:schooluniform/pages/home/widgets/bannerItem.dart';
import 'package:schooluniform/pages/home/widgets/countUpItem.dart';
import 'package:schooluniform/pages/home/widgets/drawerItem.dart';
import 'package:schooluniform/pages/home/widgets/swipeBannerItem.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  int totalBannerPage = 4;
  int bannerPage = 0;
  PageController bannerController = PageController(initialPage: 0);

  Future<void> messageHandler() async {
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      if (initialMessage.data['confirm'] == "true") {
        Navigator.of(context).pushNamed(Routes.userPurchaseUniformUrl);
      }
      if (initialMessage.data["confirm"] == "false") {
        Navigator.of(context).pushNamed(Routes.userPurchaseUniformUrl);
        Navigator.of(context).pushNamed(Routes.userPurchaseUniformRejectUrl,
            arguments: initialMessage.data["uniformId"]);
      }
    }

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        await flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                importance: Importance.max,
                priority: Priority.high,
                icon: "ic_launcher",
              ),
            ));
        Navigator.of(context).pushNamed(Routes.userPurchaseUniformUrl);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data["confirm"] == "true") {
        Navigator.of(context).pushNamed(Routes.userPurchaseUniformUrl);
      }
      if (message.data["confirm"] == "false") {
        Navigator.of(context).pushNamed(Routes.userPurchaseUniformUrl);
        Navigator.of(context).pushNamed(Routes.userPurchaseUniformRejectUrl,
            arguments: message.data["uniformId"]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    messageHandler();
    Timer.periodic(Duration(seconds: 4), (timer) {
      bannerController.animateToPage(
        (bannerPage + 1) % totalBannerPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      backgroundColor: grey2,
      appBar: Header(
        title: Text("대구 북구 교복 나눔",
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            )),
        popButton: false,
        border: false,
        actions: [
          Container(
            width: 48,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => _drawerKey.currentState.openEndDrawer(),
              child: Stack(
                children: [
                  Container(
                    child: Image(
                      image: AssetImage("assets/icon/user.png"),
                      width: 32,
                      height: 32,
                    ),
                    margin: EdgeInsets.only(right: 2),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Observer(
                          builder: (_) => infoStore.userInfo["total"] == 0
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.only(left: 1),
                                  alignment: Alignment.center,
                                  width: infoStore.userInfo["total"] < 10
                                      ? 16
                                      : 20,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: colorAlert,
                                  ),
                                  child: Text(
                                    infoStore.userInfo["total"].toString(),
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        height: 1),
                                  ),
                                )))
                ],
              ),
            ),
          )
        ],
      ),
      endDrawer: Container(
        width: 241,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.only(top: 48),
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16),
                margin: EdgeInsets.only(bottom: 24),
                child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32,
                      height: 32,
                      padding: EdgeInsets.all(6),
                      child: Image(
                          image: AssetImage("assets/icon/close.png"),
                          width: 20,
                          height: 20),
                    )),
              ),
              DrawerItemWidget(
                  label: '장바구니',
                  userInfoKey: "uniformCart",
                  url: Routes.userCartUrl),
              DrawerItemWidget(
                  label: '교복 구매 내역',
                  userInfoKey: "uniformShop",
                  url: Routes.userPurchaseUniformUrl),
              DrawerItemWidget(
                  label: '교복 기부 내역',
                  userInfoKey: "uniformDonate",
                  url: Routes.userDonateUniformUrl),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.userSupportUrl),
                child: Container(
                  height: 48,
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "후원 내역",
                        style: GoogleFonts.notoSans(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Observer(
        builder: (_) => ListView(
          children: [
            Container(
              height: 180,
              child: Stack(
                children: [
                  PageView(
                    controller: bannerController,
                    onPageChanged: (value) {
                      setState(() {
                        bannerPage = value;
                      });
                    },
                    children: [
                      SwipeBannerItemWidget(
                          url: Routes.donateStep1Url,
                          imageSrc: "assets/img/banner1.png"),
                      SwipeBannerItemWidget(
                          url: Routes.shopFilterUrl,
                          imageSrc: "assets/img/banner2.png"),
                      SwipeBannerItemWidget(
                          url: Routes.supportUrl,
                          imageSrc: "assets/img/banner3.png"),
                      SwipeBannerItemWidget(
                          url: Routes.donateThingParkingUrl,
                          imageSrc: "assets/img/banner4.png"),
                    ],
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Color(0x80000000),
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: Text("${bannerPage + 1} / $totalBannerPage",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: grey2, width: 1)),
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: "${getCurrentTime()} 현재 ",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: textGrey2)),
                        TextSpan(
                            text: infoStore.localInfo["totalStock"].toString(),
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: textGrey2)),
                        TextSpan(
                            text: "개 교복 구매 가능",
                            style: GoogleFonts.notoSans(
                                fontSize: 12, color: textGrey2)),
                      ]),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    children: [
                      CountUpItemWidget(
                        url: Routes.rankingSchoolUrl,
                        label: "누적 교복 기부 횟수",
                        condition: '',
                        secondaryLabel:
                            infoStore.localInfo["totalDonate"].toDouble(),
                      ),
                      Container(
                        width: 1,
                        height: 52,
                        color: grey2,
                        child: null,
                      ),
                      CountUpItemWidget(
                        url: Routes.rankingSchoolUrl,
                        label: "최다 기부 학교",
                        condition: getMostDonateSchool(
                            infoStore.localInfo["middleSchools"],
                            infoStore.localInfo["highSchools"])["school"],
                        secondaryLabel: getMostDonateSchool(
                                infoStore.localInfo["middleSchools"],
                                infoStore
                                    .localInfo["highSchools"])["totalDonate"]
                            .toDouble(),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12, bottom: 20),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          child: BannerItemWidget(
                              bg: grey2,
                              url: Routes.donateStep1Url,
                              imageSrc: "assets/img/bookie-banner-1.png",
                              label: "중고 교복 기부 바로가기",
                              secondaryLabel: "후배들을 위해 따뜻한 마음을 전해보세요"),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          child: BannerItemWidget(
                              bg: Color(0xffeae1f2),
                              url: Routes.shopFilterUrl,
                              imageSrc: "assets/img/bookie-banner-0.png",
                              label: "교복 구매 바로가기",
                              secondaryLabel: "기부된 교복을 무료로 나눠드려요"),
                        ),
                        Container(
                          child: BannerItemWidget(
                              bg: Color(0xffE5DDCB),
                              url: Routes.supportUrl,
                              imageSrc: "assets/img/bookie-banner-2.png",
                              label: "후원하러 가기",
                              secondaryLabel: "어려운 이들에게 희망을 나눠주세요"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
