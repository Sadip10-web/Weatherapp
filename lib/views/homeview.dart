import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/weathercontroller.dart';
import 'package:weatherapp/views/forecast_view.dart';

class Homeview extends GetView<Weathercontroller> {
  Homeview({super.key});
  final Weathercontroller wcontroller = Get.put(Weathercontroller());
  final TextEditingController txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 700;
    return Scaffold(body: SafeArea(child: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 780),
      child: Padding(padding: EdgeInsets.fromLTRB(wide ? 48 : 20, 22, wide ? 48 : 20, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [_BrandMark(), SizedBox(width: 10), Text('AERIS', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 2.4, fontSize: 17)), Spacer(), Icon(Icons.tune_rounded, color: Color(0xFFAFC4DF))]),
        const SizedBox(height: 34), Text('Weather, at a glance.', style: Theme.of(context).textTheme.headlineMedium), const SizedBox(height: 8),
        const Text('Search any city to plan the day ahead.', style: TextStyle(color: Color(0xFFAFC4DF))), const SizedBox(height: 26),
        TextField(controller: txt, textInputAction: TextInputAction.search, onSubmitted: (_) => wcontroller.fetchweather(txt.text), decoration: InputDecoration(hintText: 'Search a city', prefixIcon: const Icon(Icons.search), suffixIcon: IconButton(onPressed: () => wcontroller.fetchweather(txt.text), icon: const Icon(Icons.arrow_forward_rounded)), filled: true, fillColor: const Color(0xFF11233D), border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(vertical: 18))),
        const SizedBox(height: 26), Expanded(child: Obx(() => _content(context))),
      ])),
    ))));
  }

  Widget _content(BuildContext context) {
    if (wcontroller.isloading.value) return const Center(child: CircularProgressIndicator());
    if (wcontroller.errorMessage.value.isNotEmpty) return _Empty(icon: Icons.location_off_outlined, title: 'That place is out of reach', message: wcontroller.errorMessage.value);
    final weather = wcontroller.weather.value;
    if (weather == null) return const _Empty(icon: Icons.explore_outlined, title: 'Ready when you are', message: 'Search for a city to view the current conditions and upcoming forecast.');
    return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: double.infinity, padding: const EdgeInsets.all(28), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF245389), Color(0xFF17355F)]), borderRadius: BorderRadius.circular(28)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const Icon(Icons.location_on_outlined, size: 18), const SizedBox(width: 5), Text(weather.cityname, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)), const Spacer(), Icon(conditionIcon(weather.condition), size: 50, color: const Color(0xFFFFD878))]),
        const SizedBox(height: 28), Text('${weather.temperature.round()}°', style: const TextStyle(fontSize: 76, height: .86, fontWeight: FontWeight.w300, letterSpacing: -4)), const SizedBox(height: 12), Text(weather.condition, style: const TextStyle(fontSize: 17, color: Color(0xFFD4E5FF))),
      ])),
      const SizedBox(height: 22), SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: () => Get.to(() => ForecastView()), icon: const Icon(Icons.calendar_month_outlined), label: const Text('View forecast'), style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 17), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))))),
    ]));
  }
}

class _BrandMark extends StatelessWidget { const _BrandMark(); @override Widget build(BuildContext context) => Container(width: 32, height: 32, decoration: BoxDecoration(color: const Color(0xFF75B8FF), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.wb_sunny_rounded, color: Color(0xFF10294A), size: 20)); }
class _Empty extends StatelessWidget { final IconData icon; final String title, message; const _Empty({required this.icon, required this.title, required this.message}); @override Widget build(BuildContext context) => Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 330), child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 60, color: const Color(0xFF75B8FF)), const SizedBox(height: 20), Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 8), Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFFAFC4DF), height: 1.45))]))); }
IconData conditionIcon(String condition) { final value = condition.toLowerCase(); if (value.contains('rain') || value.contains('drizzle')) return Icons.grain_rounded; if (value.contains('cloud')) return Icons.cloud_rounded; if (value.contains('snow')) return Icons.ac_unit_rounded; if (value.contains('storm')) return Icons.thunderstorm_rounded; return Icons.wb_sunny_rounded; }
