import 'dart:convert';

import 'package:asps_ninety_project/model/model.dart';
import 'package:dio/dio.dart';

class ControllerWeather {
  Weather weather = Weather();
  bool isLoading = true;
  updateCity(String city) => weather.setCity(city);
  updateDeg(double deg) {
    weather.setDeg((deg - 273.13) * 5 / 9);
  }

  updateDec(String dec) => weather.setDes(dec);
  updateWeenspeed(int speed) => weather.setWindspeed(speed);
  updateCountry(String country) => weather.setCity(country);
  updateImage(String image) => weather.setImage(image);
  updateBackgroundImage(String backimage) => weather.setBackImage(backimage);
  updateIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  String city = 'Damascus';

  Future getWeather() async {
    updateIsLoading(true);
    var response = await Dio().get(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=2ef2302b5a7132814e9f89cb15209ce5');
    Map<String, dynamic> data = jsonDecode(response.toString());
    updateCity(data['sys']['country'].toString());
    updateDeg(data['main']['temp']);
    updateDec(data['weather']['main'].toString());
    updateIsLoading(false);
  }
}
