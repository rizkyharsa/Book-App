import 'package:book_app/modules/home/screen/home_screen.dart';
import 'package:book_app/modules/liked/screen/liked_book_screen.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  final currentPage = 0.obs;

  final List page = const [
    HomeScreen(),
    LikedBookScreen(),
  ];
}
