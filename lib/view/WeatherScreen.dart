// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'dart:ui';

import 'package:asps_ninety_project/components/components.dart';
import 'package:asps_ninety_project/controller/controller.dart';
import 'package:asps_ninety_project/model/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class weatherScreen extends StatefulWidget {
  @override
  _weatherScreenState createState() => _weatherScreenState();
}

class _weatherScreenState extends State<weatherScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat(reverse: true);
  late Animation<Offset> animation =
      Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -0.1))
          .animate(animationController);
  Color beginGadientColor = HexColor('#E16550');
  Color endGadientColor = HexColor('#ECB969');
  ControllerWeather controllerWeather = ControllerWeather();
  late double _height = ResposiveHelper.fromHeight(0.38);
  late double _width = ResposiveHelper.fromWidth(0.35);
  final countrylist = [
    'Damascus',
    'Tokyo',
    'Delhi',
    'Shanghai',
    'Sao Paulo',
    'Cairo ',
    'Istanbul',
    'Fukuoka',
    'Paris',
    'Jiddah',
    'Aleppo',
    'Chelyabinsk',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controllerWeather.getWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    ResposiveHelper(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [beginGadientColor, endGadientColor]),
                ),
                child: SafeArea(
                  minimum: EdgeInsets.only(top: 60),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Stack(
                      children: [
                        SvgPicture.asset(controllerWeather.weather.backImage),
                        ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Container(
                              height: 600,
                              decoration: BoxDecoration(
                                  color: Colors.white10,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 1),
                                        color: Colors.white10,
                                        blurRadius: 2,
                                        spreadRadius: 2)
                                  ]),
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: ResposiveHelper.fromHeight(.01),
                            ),
                            Text(
                              'Weather',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: ResposiveHelper.fromFontSize(0.04),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              controllerWeather.weather.description,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: ResposiveHelper.fromFontSize(0.035),
                                color: Colors.white,
                              ),
                            ),
                            DropdownButton<String>(
                              hint: Text(
                                controllerWeather.city,
                                style: TextStyle(color: Colors.white),
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  controllerWeather.city = newValue!;
                                  controllerWeather.getWeather();
                                  if (controllerWeather.weather.deg >= 40) {
                                    beginGadientColor = HexColor('#E16550');
                                    endGadientColor = HexColor('ECB969');
                                    controllerWeather
                                        .updateImage('assets/Images/sun.svg');
                                    controllerWeather.updateBackgroundImage(
                                        'assets/Images/sunny_back.svg');
                                  } else if (controllerWeather.weather.deg <=
                                      20) {
                                    beginGadientColor = HexColor('#7B858F');
                                    endGadientColor = HexColor('#ECB969');
                                    controllerWeather.updateImage(
                                        'assets/Images/half_sunny.svg');
                                    controllerWeather.updateBackgroundImage(
                                        'assets/Images/metro_back.svg');

                                    _height = ResposiveHelper.fromHeight(0.45);
                                  } else if (controllerWeather.weather.deg >=
                                          2 &&
                                      controllerWeather.weather.deg <= 20) {
                                    beginGadientColor = HexColor('#B7C4D4');
                                    endGadientColor = HexColor('#0095AF');
                                    controllerWeather.updateBackgroundImage(
                                        'assets/Images/rainning_back.svg');
                                    controllerWeather.updateImage(
                                        'assets/Images/raining_1.svg');
                                    //    BackgroundImage =
                                    'assets/Images/rainning_back.svg';
                                    //   Image = 'assets/Images/raining_1.svg';

                                    _height = ResposiveHelper.fromHeight(0.45);
                                  } else if (controllerWeather.weather.deg <
                                      0) {
                                    beginGadientColor = HexColor('#B7C4D4');
                                    endGadientColor = HexColor('#0095AF');
                                    controllerWeather.updateBackgroundImage(
                                        'assets/Images/rainning_back2.svg');
                                    controllerWeather.updateImage(
                                        'assets/Images/raining_2.svg');
                                    //    BackgroundImage =
                                    'assets/Images/rainning_back.svg';
                                    //   Image = 'assets/Images/raining_1.svg';

                                    _height = ResposiveHelper.fromHeight(0.45);
                                  }
                                });
                              },
                              items: countrylist.map(buildemenu).toList(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                AnimatedContainer(
                                  curve: Curves.ease,
                                  width: _width,
                                  height: _height,
                                  duration: const Duration(milliseconds: 400),
                                  child: SlideTransition(
                                    position: animation,
                                    child: SvgPicture.asset(
                                      controllerWeather.weather.urlImage,
                                    ),
                                  ),
                                ),
                                Text(
                                  controllerWeather.weather.deg
                                          .round()
                                          .toString() +
                                      "°",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize:
                                          ResposiveHelper.fromFontSize(0.049),
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200),
                                )
                              ],
                            ),
                            Container(
                              height: ResposiveHelper.fromHeight(0.3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white70,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      daysText(text: 'Today'),
                                      daysText(text: 'Monday'),
                                      daysText(text: 'Thrsday'),
                                      daysText(text: 'Wensday'),
                                      daysText(text: 'Wensday'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      imagesButton(
                                          function: () {
                                            setState(() {
                                              beginGadientColor =
                                                  HexColor('#E16550');
                                              endGadientColor =
                                                  HexColor('ECB969');
                                              controllerWeather.updateImage(
                                                  'assets/Images/sun.svg');
                                              controllerWeather
                                                  .updateBackgroundImage(
                                                      'assets/Images/sunny_back.svg');
                                              controllerWeather.updateDeg(32);
                                              _height =
                                                  ResposiveHelper.fromHeight(
                                                      0.45);
                                            });
                                          },
                                          imagePath: 'assets/Images/sun.svg'),
                                      imagesButton(
                                          function: () {
                                            setState(() {
                                              beginGadientColor =
                                                  HexColor('#7B858F');
                                              endGadientColor =
                                                  HexColor('#ECB969');
                                              controllerWeather.updateImage(
                                                  'assets/Images/half_sunny.svg');
                                              controllerWeather
                                                  .updateBackgroundImage(
                                                      'assets/Images/metro_back.svg');
                                              controllerWeather.updateDeg(
                                                15,
                                              );
                                              _height =
                                                  ResposiveHelper.fromHeight(
                                                      0.45);
                                            });
                                          },
                                          imagePath:
                                              'assets/Images/half_sunny.svg'),
                                      imagesButton(
                                          function: () {
                                            setState(() {
                                              beginGadientColor =
                                                  HexColor('#7B858F');
                                              endGadientColor =
                                                  HexColor('#ECB969');
                                              controllerWeather.updateImage(
                                                  'assets/Images/half_sunny.svg');
                                              controllerWeather
                                                  .updateBackgroundImage(
                                                      'assets/Images/metro_back.svg');
                                              controllerWeather.updateDeg(
                                                15,
                                              );
                                              _height =
                                                  ResposiveHelper.fromHeight(
                                                      0.45);
                                            });
                                          },
                                          imagePath:
                                              'assets/Images/half_sunny.svg'),
                                      imagesButton(
                                          function: () {
                                            setState(() {
                                              beginGadientColor =
                                                  HexColor('#B7C4D4');
                                              endGadientColor =
                                                  HexColor('#0095AF');
                                              controllerWeather
                                                  .updateBackgroundImage(
                                                      'assets/Images/rainning_back.svg');
                                              controllerWeather.updateImage(
                                                  'assets/Images/raining_1.svg');
                                              //    BackgroundImage =
                                              'assets/Images/rainning_back.svg';
                                              //   Image = 'assets/Images/raining_1.svg';
                                              controllerWeather.updateDeg(
                                                7,
                                              );
                                              _height =
                                                  ResposiveHelper.fromHeight(
                                                      0.45);
                                            });
                                          },
                                          imagePath:
                                              'assets/Images/raining_1.svg'),
                                      imagesButton(
                                          function: () {
                                            setState(() {
                                              beginGadientColor =
                                                  HexColor('#B7C4D4');
                                              endGadientColor =
                                                  HexColor('#0095AF');
                                              controllerWeather
                                                  .updateBackgroundImage(
                                                      'assets/Images/rainning_back2.svg');
                                              controllerWeather.updateImage(
                                                  'assets/Images/raining_2.svg');
                                              //    BackgroundImage =
                                              'assets/Images/rainning_back.svg';
                                              //   Image = 'assets/Images/raining_1.svg';
                                              controllerWeather.updateDeg(
                                                2,
                                              );
                                              _height =
                                                  ResposiveHelper.fromHeight(
                                                      0.45);
                                            });
                                          },
                                          imagePath:
                                              'assets/Images/raining_2.svg'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      degText(text: '32°'),
                                      degText(text: '25°'),
                                      degText(text: '22°'),
                                      degText(text: '12°'),
                                      degText(text: '9°'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}

Widget isLoading() => Center(child: CircularProgressIndicator());
