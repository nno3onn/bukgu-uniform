import 'package:flutter/material.dart';
import 'package:schooluniform/pages/donate/thing/parking.dart';
import 'package:schooluniform/pages/donate/uniform/step1-1.dart';
import 'package:schooluniform/pages/donate/uniform/step1-2.dart';
import 'package:schooluniform/pages/donate/uniform/step1-3.dart';
import 'package:schooluniform/pages/donate/uniform/step1-4.dart';
import 'package:schooluniform/pages/donate/uniform/step1.dart';
import 'package:schooluniform/pages/donate/uniform/step3.dart';
import 'package:schooluniform/pages/donate/uniform/step4.dart';
import 'package:schooluniform/pages/donate/uniform/step5.dart';
import 'package:schooluniform/pages/home/page.dart';
import 'package:schooluniform/pages/init/page.dart';
import 'package:schooluniform/pages/policy/page.dart';
import 'package:schooluniform/pages/ranking/school/page.dart';
import 'package:schooluniform/pages/shop/buy/uniform/step1.dart';
import 'package:schooluniform/pages/shop/buy/uniform/step2.dart';
import 'package:schooluniform/pages/shop/buy/uniform/step3.dart';
import 'package:schooluniform/pages/shop/filter/page.dart';
import 'package:schooluniform/pages/shop/list/widgets/filterCloth.dart';
import 'package:schooluniform/pages/shop/list/widgets/filterGender.dart';
import 'package:schooluniform/pages/shop/list/page.dart';
import 'package:schooluniform/pages/shop/show/page.dart';
import 'package:schooluniform/pages/shop/show/pageDirect.dart';
import 'package:schooluniform/pages/support/page.dart';
import 'package:schooluniform/pages/user/cart/page.dart';
import 'package:schooluniform/pages/user/donate/uniform/page.dart';
import 'package:schooluniform/pages/user/purchase/uniform/page.dart';
import 'package:schooluniform/pages/user/purchase/uniform/reject/reject.dart';
import 'package:schooluniform/pages/user/support/page.dart';

class Routes {
  Routes._();

  static const String initUrl = "/init";
  static const String homeUrl = "/home";
  static const String donateThingParkingUrl = "/donate/thing/parking";
  static const String donateStep1Url = "/donate/uniform/1";
  static const String donateStep2Url = "/donate/uniform/2";
  static const String donateStep3Url = "/donate/uniform/3";
  static const String donateStep4Url = "/donate/uniform/4";
  static const String donateStep5Url = "/donate/uniform/5";
  static const String donateStep1_1Url = "/donate/uniform/1-1";
  static const String donateStep1_2Url = "/donate/uniform/1-2";
  static const String donateStep1_3Url = "/donate/uniform/1-3";
  static const String donateStep1_4Url = "/donate/uniform/1-4";
  static const String shopFilterUrl = "/shop/filter";
  static const String shopListUrl = "/shop/list";
  static const String shopListGenderFilterUrl =
      "/shop/uniform/list/filter/gender";
  static const String shopListClothFilterUrl =
      "/shop/uniform/list/filter/cloth";
  static const String shopShowUrl = "/shop/show";
  static const String shopShowDirectUrl = "/shop/show/direct";
  static const String shopStep1Url = "/shop/uniform/1";
  static const String shopStep2Url = "/shop/uniform/2";
  static const String shopStep3Url = "/shop/uniform/3";
  static const String supportUrl = "/support";
  static const String userCartUrl = "/user/cart";
  static const String userDonateUniformUrl = "/user/uniform/donate";
  static const String userPurchaseUniformUrl = "/user/uniform/purchase";
  static const String userPurchaseUniformRejectUrl =
      "/user/uniform/purchase/reject";
  static const String userSupportUrl = "/user/support";
  static const String policyUrl = "/policy";
  static const String rankingSchoolUrl = "/ranking/school";
}

Route<dynamic> routeGenerator(RouteSettings settings) {
  if (settings.name == Routes.initUrl) {
    return MaterialPageRoute(
      builder: (context) => InitPage(),
      settings: settings,
    );
  } else if (settings.name == Routes.homeUrl) {
    return PageRouteBuilder(
      pageBuilder: (context, _ani1, _ani2) => HomePage(),
      settings: settings,
    );
  } else if (settings.name == Routes.donateThingParkingUrl) {
    return MaterialPageRoute(
      builder: (context) => DonateThingParking(),
      settings: settings,
    );
  } else if (settings.name == Routes.donateStep1Url) {
    return MaterialPageRoute(
      builder: (context) => DonateStep1(),
      settings: settings,
    );
  } else if (settings.name == Routes.donateStep3Url) {
    return MaterialPageRoute(
      builder: (context) => DonateStep3(),
      settings: settings,
    );
  } else if (settings.name == Routes.donateStep4Url) {
    return MaterialPageRoute(
      builder: (context) => DonateStep4(),
      settings: settings,
    );
  } else if (settings.name == Routes.donateStep5Url) {
    return MaterialPageRoute(
      builder: (context) => DonateStep5(),
      settings: settings,
    );
  } else if (settings.name == Routes.donateStep1_1Url) {
    return MaterialPageRoute(
      builder: (context) => DonateStep1_1(),
      settings: settings,
    );
  } else if (settings.name == Routes.donateStep1_2Url) {
    return MaterialPageRoute(
      builder: (context) => DonateStep1_2(),
      settings: settings,
    );
  } else if (settings.name == Routes.donateStep1_3Url) {
    return MaterialPageRoute(
      builder: (context) => DonateStep1_3(),
      settings: settings,
    );
  } else if (settings.name == Routes.donateStep1_4Url) {
    return MaterialPageRoute(
      builder: (context) => DonateStep1_4(),
      settings: settings,
    );
  } else if (settings.name == Routes.shopFilterUrl) {
    return MaterialPageRoute(
      builder: (context) => ShopFilterPage(),
      settings: settings,
    );
  } else if (settings.name == Routes.shopListUrl) {
    return MaterialPageRoute(
      builder: (context) => ShopListPage(),
      settings: settings,
    );
  } else if (settings.name == Routes.shopListGenderFilterUrl) {
    return MaterialPageRoute(
      builder: (context) => ShopListGenderFilter(),
      settings: settings,
    );
  } else if (settings.name == Routes.shopListClothFilterUrl) {
    return MaterialPageRoute(
      builder: (context) => ShopListClothFilter(),
      settings: settings,
    );
  } else if (settings.name == Routes.shopShowUrl) {
    return MaterialPageRoute(
      builder: (context) => ShopShowPage(),
      settings: settings,
    );
  } else if (settings.name == Routes.shopShowDirectUrl) {
    return MaterialPageRoute(
      builder: (context) => ShopShowDirectPage(
        code: settings.arguments,
      ),
      settings: settings,
    );
  } else if (settings.name == Routes.shopStep1Url) {
    return MaterialPageRoute(
      builder: (context) => ShopStep1(),
      settings: settings,
    );
  } else if (settings.name == Routes.shopStep2Url) {
    return MaterialPageRoute(
      builder: (context) => ShopStep2(),
      settings: settings,
    );
  } else if (settings.name == Routes.shopStep3Url) {
    return MaterialPageRoute(
      builder: (context) => ShopStep3(),
      settings: settings,
    );
  } else if (settings.name == Routes.supportUrl) {
    return MaterialPageRoute(
      builder: (context) => SupportPage(),
      settings: settings,
    );
  } else if (settings.name == Routes.userCartUrl) {
    return MaterialPageRoute(
      builder: (context) => UserCartPage(),
      settings: settings,
    );
  } else if (settings.name == Routes.userDonateUniformUrl) {
    return MaterialPageRoute(
      builder: (context) => UserDonateUniformPage(),
      settings: settings,
    );
  } else if (settings.name == Routes.userPurchaseUniformUrl) {
    return MaterialPageRoute(
      builder: (context) => UserPurchaseUniformPage(),
      settings: settings,
    );
  } else if (settings.name == Routes.userPurchaseUniformRejectUrl) {
    return MaterialPageRoute(
      builder: (context) => UserPurchaseUniformRejectPage(
        code: settings.arguments,
      ),
      settings: settings,
    );
  } else if (settings.name == Routes.userSupportUrl) {
    return MaterialPageRoute(
      builder: (context) => UserSupportPage(),
      settings: settings,
    );
  } else if (settings.name == Routes.policyUrl) {
    return MaterialPageRoute(
      builder: (context) => PolicyPage(),
      settings: settings,
    );
  } else if (settings.name == Routes.rankingSchoolUrl) {
    return MaterialPageRoute(
      builder: (context) => RankingSchoolPage(),
      settings: settings,
    );
  }
}
