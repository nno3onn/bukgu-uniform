import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:schooluniform/configs/routes.dart';

void main() {
  runApp(Mogwon());
}

class Mogwon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: "daegu-bukgu-schooluniform",
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      initialRoute: Routes.initUrl,
      onGenerateRoute: routeGenerator,
    );
  }
}
