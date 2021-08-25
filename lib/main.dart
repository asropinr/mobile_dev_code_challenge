import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesscase/screen/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: ScreenUtilInit());
  }
}

class ScreenUtilInit extends StatelessWidget {
  const ScreenUtilInit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Init screen util
    ScreenUtil.init(
      context,
      // Based on iPhone X / Figma layout resolution
      // device uikit height size subtract with status bar height, 44 px
      designSize: Size(375, 812),
      // Not allowing font scaling
      allowFontScaling: false,
    );

    return HomePage();
  }
}
