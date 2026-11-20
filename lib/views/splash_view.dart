import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/views/homeview.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1800), () => Get.off(() => Homeview()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF142E54), Color(0xFF071324), Color(0xFF09192E)])),
      child: Center(child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 900), tween: Tween(begin: .82, end: 1), curve: Curves.easeOutBack,
        builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
        child: const Column(mainAxisSize: MainAxisSize.min, children: [
          _WeatherMark(), SizedBox(height: 24),
          Text('AERIS', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: 5)),
          SizedBox(height: 8), Text('Your weather, beautifully clear', style: TextStyle(color: Color(0xFFAFC4DF))),
          SizedBox(height: 42), SizedBox(width: 130, child: LinearProgressIndicator(minHeight: 3)),
        ]),
      )),
    ),
  );
}

class _WeatherMark extends StatelessWidget {
  const _WeatherMark();
  @override
  Widget build(BuildContext context) => Container(
    width: 92, height: 92,
    decoration: BoxDecoration(color: const Color(0xFF79BDFF), borderRadius: BorderRadius.circular(28), boxShadow: const [BoxShadow(color: Color(0x6679BDFF), blurRadius: 30)]),
    child: const Icon(Icons.wb_sunny_rounded, color: Color(0xFF10294A), size: 52),
  );
}
