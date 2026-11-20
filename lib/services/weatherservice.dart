import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weatherapp/models/forecast.dart';
import 'package:weatherapp/models/weathermodel.dart';

class Weatherservice {
  final Dio d=Dio();

 Future <Weathermodel>getweather(String cityname) async{
   

    var response=await d.get("https://api.openweathermap.org/data/2.5/weather",queryParameters:{
      "q":cityname,
      "appid":"36d3079592b6cdb13a8081b754c76f7a",
      "units":"metric"
    });
  return Weathermodel(
    cityname: response.data["name"],
    temperature: response.data["main"]["temp"],
    condition: response.data["weather"][0]["main"]
    );
   
   
  }
 Future<List<Forecast>> getForecast(String cityname) async{
      var response=await d.get("https://api.openweathermap.org/data/2.5/forecast",queryParameters:{
      "q":cityname,
      "appid":"36d3079592b6cdb13a8081b754c76f7a",
      "units":"metric"
    });
     var forecastlist=response.data["list"];

    return forecastlist.map<Forecast>((json)=>Forecast.fromJson(json)).toList();
  
}
}