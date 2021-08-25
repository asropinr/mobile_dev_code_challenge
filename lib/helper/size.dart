import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdaptiveSize {
  static double width(double designWidth) {
    return ScreenUtil().setWidth(designWidth);
  }

  static double height(double designHeight) {
    return ScreenUtil().setHeight(designHeight);
  }
}
