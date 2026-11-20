class Forecast{
  final DateTime date;
  final double temperature;
  final String condition;

  const Forecast({
    required this.date,
    required this.temperature,
    required this.condition
  });

  factory Forecast.fromJson(Map<String,dynamic> json){
    return Forecast(date:DateTime.parse(json["dt_txt"]),
     temperature: (json["main"]["temp"]as num).toDouble(),
      condition: json["weather"][0]["main"]);
  }

}