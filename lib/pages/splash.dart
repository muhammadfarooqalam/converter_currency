// ignore_for_file: file_names

import 'dart:async';
import 'package:converter_currency/pages/currency_converter_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CurrencyConverterPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }

  Widget content() {
    return Center(
      child:
          Container(child: Lottie.asset('assets/svgs/animation_lleub74g.json')),
    );
  }
}
