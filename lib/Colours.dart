import 'package:flutter/material.dart';

class Colours {

  static const Map<int, Color> accentShades =
  {
    50:const Color.fromRGBO(249, 170, 51, .1),
    100:const Color.fromRGBO(249, 170, 51, .2),
    200:const Color.fromRGBO(249, 170, 51, .3),
    300:const Color.fromRGBO(249, 170, 51, .4),
    400:const Color.fromRGBO(249, 170, 51, .5),
    500:const Color.fromRGBO(249, 170, 51, .6),
    600:const Color.fromRGBO(249, 170, 51, .7),
    700:const Color.fromRGBO(249, 170, 51, .8),
    800:const Color.fromRGBO(249, 170, 51, .9),
    900:const Color.fromRGBO(249, 170, 51, 1),
  };

  static const MaterialColor accentMat = MaterialColor(0xFFF9AA33, accentShades);

  static const Color accent = Color(0xFFF9AA33);

  static const Map<int, Color> primaryShades =
  {
    50:const Color.fromRGBO(52, 73, 85, .1),
    100:const Color.fromRGBO(52, 73, 85, .2),
    200:const Color.fromRGBO(52, 73, 85, .3),
    300:const Color.fromRGBO(52, 73, 85, .4),
    400:const Color.fromRGBO(52, 73, 85, .5),
    500:const Color.fromRGBO(52, 73, 85, .6),
    600:const Color.fromRGBO(52, 73, 85, .7),
    700:const Color.fromRGBO(52, 73, 85, .8),
    800:const Color.fromRGBO(52, 73, 85, .9),
    900:const Color.fromRGBO(52, 73, 85, 1),
  };

  static const MaterialColor primaryMat = MaterialColor(0xFFF9AA33, primaryShades);

  static const Color primary = Color(0xFF344955);

}
