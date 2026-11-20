import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/weathercontroller.dart';
import 'package:weatherapp/views/homeview.dart';

class ForecastView extends StatelessWidget {
  ForecastView({super.key});
  final Weathercontroller wcontroller = Get.find<Weathercontroller>();

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 700;
    return Scaffold(body: SafeArea(child: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 780),
      child: Padding(padding: EdgeInsets.symmetric(horizontal: wide ? 48 : 20, vertical: 16), child: Obx(() {
        if (wcontroller.isloading.value) return const Center(child: CircularProgressIndicator());
        if (wcontroller.frstcst.isEmpty) return const Center(child: Text('No forecast data available.'));
        final city = wcontroller.weather.value?.cityname ?? 'Your city';
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [IconButton(onPressed: Get.back, icon: const Icon(Icons.arrow_back_rounded)), const SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Forecast', style: Theme.of(context).textTheme.headlineMedium), Text(city, style: const TextStyle(color: Color(0xFFAFC4DF)))]))]),
          const SizedBox(height: 26), const Text('NEXT 5 DAYS', style: TextStyle(fontSize: 12, letterSpacing: 1.4, color: Color(0xFFAFC4DF), fontWeight: FontWeight.w700)), const SizedBox(height: 12),
          Expanded(child: ListView.separated(itemCount: wcontroller.frstcst.length, separatorBuilder: (_, __) => const SizedBox(height: 10), itemBuilder: (context, index) {
            final item = wcontroller.frstcst[index];
            return Container(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16), decoration: BoxDecoration(color: const Color(0xFF11233D), borderRadius: BorderRadius.circular(18)), child: Row(children: [Icon(conditionIcon(item.condition), color: const Color(0xFFFFD878)), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(dateLabel(item.date), style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 3), Text(item.condition, style: const TextStyle(color: Color(0xFFAFC4DF), fontSize: 13))])), Text('${item.temperature.round()}°', style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w300))]));
          })),
        ]);
      })),
    ))));
  }
}

String dateLabel(DateTime date) { const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']; const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']; return '${days[date.weekday - 1]}, ${months[date.month - 1]} ${date.day} · ${date.hour.toString().padLeft(2, '0')}:00'; }
