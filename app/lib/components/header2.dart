import "package:flutter/material.dart";
import 'package:schooluniform/constants/theme.dart';

class Header2 extends StatelessWidget implements PreferredSizeWidget {
  Header2({
    this.popButton,
    this.title,
    this.actions,
    this.border,
  });

  final bool popButton;
  final Text title;
  final List<Widget> actions;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(46),
      child: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: popButton
            ? Container(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5, right: 12),
                      color: Colors.transparent,
                      child: Image(
                        image: AssetImage("assets/icon/close-padding.png"),
                      ),
                    )),
              )
            : Container(),
        centerTitle: true,
        title: title,
        actions: actions == null ? [Container()] : actions,
        bottom: border
            ? PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(width: 1, color: grey2))),
                ),
              )
            : PreferredSize(
                child: Container(),
                preferredSize: Size.zero,
              ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(46);
}
