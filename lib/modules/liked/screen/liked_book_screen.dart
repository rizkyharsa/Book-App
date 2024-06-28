import 'package:book_app/common/constant.dart';
import 'package:flutter/material.dart';

class LikedBookScreen extends StatelessWidget {
  const LikedBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Container(
            height: height * .25,
            width: width,
            decoration: BoxDecoration(
                // color: primaryColor,
                ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                ),
                Positioned(
                  left: 155,
                  right: 155,
                  child: Container(
                    height: height * .15,
                    width: width * .25,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
