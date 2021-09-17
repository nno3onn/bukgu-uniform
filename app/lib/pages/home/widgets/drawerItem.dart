import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schooluniform/configs/stores.dart';
import 'package:schooluniform/constants/theme.dart';

class DrawerItemWidget extends StatelessWidget {
  final String label;
  final String userInfoKey;
  final String url;
  DrawerItemWidget({this.label, this.userInfoKey, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(url),
      child: Container(
        height: 48,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.notoSans(fontSize: 16),
            ),
            Observer(
                builder: (_) => infoStore.userInfo[userInfoKey] == 0
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 1),
                        alignment: Alignment.center,
                        width: infoStore.userInfo[userInfoKey] < 10 ? 16 : 20,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: colorAlert,
                        ),
                        child: Text(
                          infoStore.userInfo[userInfoKey].toString(),
                          style: GoogleFonts.montserrat(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1),
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
