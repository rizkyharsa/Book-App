import 'package:book_app/common/constant.dart';
import 'package:book_app/controller/main_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends GetView<MainPageController> {
  const MainPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
        body: Obx(
          () => SafeArea(
            child: controller.page[controller.currentPage.value],
          ),
        ),
        bottomNavigationBar: GNav(
          onTabChange: (value) {
            controller.currentPage(value);
          },
          tabBackgroundColor: fourthColor,
          padding: const EdgeInsets.all(10),
          tabMargin: const EdgeInsets.all(5),
          curve: Curves.easeInOutQuart,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          color: primaryColor,
          activeColor: primaryColor,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.favorite,
              text: "Likes",
            ),
          ],
        ));
  }
}
