import 'package:flutter/cupertino.dart';

class AppSize{
  static double screenWidth(BuildContext context){
    return MediaQuery.sizeOf(context).width;
  }
  static double screenHeight(BuildContext context){
    return MediaQuery.sizeOf(context).height;
  }
}