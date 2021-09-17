import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import 'package:schooluniform/configs/routes.dart';
import 'package:schooluniform/configs/stores.dart';
import 'package:schooluniform/pages/init/widgets/updateMessageModal.dart';

class InitPage extends StatefulWidget {
  @override
  InitPageState createState() => InitPageState();
}

class InitPageState extends State<InitPage> {
  bool authCheck = false;

  void handleAuth() async {
    try {
      await Firebase.initializeApp();
      await infoStore.initData();
      setState(() {
        authCheck = true;
      });

      FirebaseMessaging messaging = FirebaseMessaging.instance;

      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );

      if (infoStore.localInfo["shouldBeUpdated"]) {
        updateMessageModal(context: context);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.homeUrl);
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    handleAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
          ),
        ),
        body: Container(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(bottom: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                      image: AssetImage("assets/img/bookie-main.png"),
                      width: 164,
                      height: 164),
                  Container(
                    margin: EdgeInsets.only(top: 12, bottom: 64),
                    child: Text(
                      "대구 북구 교복 나눔",
                      style: GoogleFonts.notoSans(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )));
  }
}
