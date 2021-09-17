import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooluniform/configs/routes.dart';
import 'package:schooluniform/configs/stores.dart';
import 'package:schooluniform/constants/theme.dart';
import 'package:schooluniform/pages/shop/list/types/pageArg.dart';

class ListViewWidget extends StatelessWidget {
  final List data;
  final String ref;
  ListViewWidget({this.data, this.ref});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var i in data)
          GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(Routes.shopListUrl,
                  arguments: ShopListPageArg(schoolName: i)),
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 48,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 16, right: 8),
                      child: Text(
                        i,
                        style: GoogleFonts.notoSans(fontSize: 14),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: grey2,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text(
                            infoStore.localInfo[ref][i]["totalStock"].toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                height: 1,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff444444)),
                          ),
                        )),
                  ],
                ),
              ))
      ],
    );
  }
}
