import 'dart:async';

import 'package:book_app/common/constant.dart';
import 'package:book_app/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(
      duration,
      () {
        Get.offAll(() => const MainPage(), transition: Transition.rightToLeft);
      },
    );
  }

  @override
  void initState() {
    startSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: fourthColor,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/BOOK APP.png",
                    scale: 1,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
