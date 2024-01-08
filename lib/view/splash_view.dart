import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () => Get.off(const HomeView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splash_pic.jpg',
            width: Get.width * 0.9,
            height: Get.height * 0.5,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          Text(
            'TOP HEADLINES',
            style: GoogleFonts.anton(
                letterSpacing: 6, color: Colors.grey.shade700, fontSize: 16),
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          SpinKitChasingDots(
            color: Colors.blue,
            size: Get.height * 0.05,
          )
        ],
      ),
    );
  }
}
