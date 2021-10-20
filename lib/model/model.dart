class Weather {
  late String city;
  late double deg;
  late String description;
  late int windspeed;
  late String country;
  late String urlImage;
  late String backImage;
  late bool isLoading;

  Weather(
      {this.city = 'damascus',
      this.deg = 0,
      this.country = 'syria',
      this.description = 'Today',
      this.windspeed = 400,
      this.urlImage = 'assets/Images/sun.svg',
      this.backImage = 'assets/Images/background_sun.svg',
      this.isLoading = true});

  setCity(String city) {
    this.city = city;
  }

  setDeg(double deg) {
    this.deg = deg;
  }

  setDes(String description) {
    this.description = description;
  }

  setWindspeed(int windspeed) {
    this.windspeed = windspeed;
  }

  setCountey(String country) {
    this.country = country;
  }

  setImage(String urlImage) {
    this.urlImage = urlImage;
  }

  setBackImage(String backImage) {
    this.backImage = backImage;
  }

  setIsloading(bool isLoading) {
    this.isLoading = isLoading;
  }
}
