import 'package:http/http.dart';
import './models/plant.dart';
import 'dart:convert';
import 'dart:math';
import 'package:geolocator/geolocator.dart';

class HttpService {
  static String baseUrl = 'https://pickplant.herokuapp.com';

  Future<List<Plant>> postForm(Plant plant) async {
    //Uri url = new Uri.http(baseUrl, '/pick');
    String url = baseUrl + '/pick';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = jsonEncode(plant);
    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    print("STATUS_CODE=" + statusCode.toString());
    if (response.statusCode == 201) {
      List<dynamic> plants = jsonDecode(response.body);
      //plants.addAll(jsonDecode(response.body));
      List<Plant> plantsMapped =
          plants.map((data) => Plant.fromJson(data)).toList();
      //plantsMapped.sort((a, b) => a.match.compareTo(b.match))
      return plantsMapped;
    } else {
      throw Exception('Failed to load plants');
    }
  }

  suggestPlant(Plant plant) async {
    String url = baseUrl + '/suggest';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = jsonEncode(plant);
    await post(url, headers: headers, body: json);
  }

  getWeather() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    String url = "https://pro.openweathermap.org/data/2.5/climate/month?lat=" +
        position.latitude.toString() +
        "&lon=" +
        position.longitude.toString() +
        "&appid=";
    Response response = await get(url);
    double maxHumidity = 0, minHumidity = 100;
    double maxTemperature = -100, minTemperature = 500;
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      List<dynamic> days = data["list"];
      for (dynamic day in days) {
        maxHumidity = max(maxHumidity, day["humidity"].toDouble());
        minHumidity = min(minHumidity, day["humidity"].toDouble());
        maxTemperature =
            max(maxTemperature, day["temp"]["average_max"].toDouble());
        minTemperature =
            max(minTemperature, day["temp"]["average_min"].toDouble());
      }
      var weather = {
        'maxHumidity': maxHumidity.round(),
        'minHumidity': minHumidity.round(),
        'maxTemperature': maxTemperature.round(),
        'minTemperature': minTemperature.round()
      };
      print(weather);

      return weather;
    }
  }
}
