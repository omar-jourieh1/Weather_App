import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

Widget degText({required String text}) => Text(
      text,
      style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: ResposiveHelper.fromFontSize(0.019),
          color: Colors.black,
          fontWeight: FontWeight.w200),
    );

Widget daysText({required String text}) => Text(
      text,
      style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: ResposiveHelper.fromFontSize(0.015),
          color: HexColor('#7645E6'),
          fontWeight: FontWeight.w200),
    );

Widget imagesButton({required Function function, required String imagePath}) =>
    GestureDetector(
      onTap: () {
        function();
      },
      child: SvgPicture.asset(
        imagePath,
        height: ResposiveHelper.fromWidth(0.15),
      ),
    );

DropdownMenuItem<String> buildemenu(String item) {
  return DropdownMenuItem(
    value: item,
    child: Container(
        decoration: BoxDecoration(color: Colors.orange),
        child: Text(item, style: TextStyle(color: Colors.white))),
  );
}

class ResposiveHelper {
  static late double height;
  static late double width;
  static late double fontsize;

  ResposiveHelper(context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    fontsize = sqrt(pow(height, 2) + pow(width, 2));
  }

  static double fromHeight(double per) {
    return height * per;
  }

  static double fromWidth(double per) {
    return width * per;
  }

  static double fromFontSize(double per) {
    return fontsize * per;
  }
}
