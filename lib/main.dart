import 'package:book_app/common/constant.dart';
import 'package:book_app/controller/main_page_controller.dart';
import 'package:book_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "BOOK APP",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: whiteColor,
        textTheme: GoogleFonts.nunitoSansTextTheme(),
      ),
      home: Builder(
        builder: (context) {
          return const SplashScreen();
        },
      ),
      initialBinding: BindingsBuilder(
        () {
          Get.lazyPut(() => MainPageController(), fenix: true);
        },
      ),
    );
  }
}
