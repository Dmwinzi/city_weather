
import 'package:flutter/cupertino.dart';

class ScreenUtils {
  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getAdaptiveFontSize(BuildContext context, {double factor = 0.05}) =>
      getScreenWidth(context) * factor;


}