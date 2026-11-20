import 'package:get/get.dart';
import 'package:weatherapp/models/forecast.dart';
import 'package:weatherapp/models/weathermodel.dart';
import 'package:weatherapp/services/weatherservice.dart';

class Weathercontroller extends GetxController {
  Weatherservice w=Weatherservice();
 final weather=Rxn<Weathermodel>();
 final frstcst=<Forecast>[].obs;
   var isloading=false.obs;
   final errorMessage = ''.obs;

  Future  fetchweather( String cityname)async{
    if (cityname.trim().isEmpty) {
      errorMessage.value = 'Enter a city name to see its weather.';
      return;
    }
    try{
    isloading(true);
    errorMessage.value = '';
    
     final results=await Future.wait([w.getweather(cityname),
     w.getForecast(cityname)
     ]);
     weather.value=results[0] as Weathermodel;
     frstcst.value=results[1] as List<Forecast>;
     }
     
  
  catch(e){
    errorMessage.value = 'We could not find that city. Please try again.';
  }
  finally{
    isloading(false);

  }
  
  }

}
