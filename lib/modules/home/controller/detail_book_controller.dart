import 'package:book_app/modules/home/models/result.dart';
import 'package:book_app/modules/home/repository/home_repository.dart';
import 'package:get/get.dart';

class DetailBookController extends GetxController {
  final detailBook = Result().obs;
  var isDataLoading = false.obs;

  @override
  void onInit() {
    getDetailBook(Get.arguments);
    super.onInit();
  }

  void getDetailBook(int id) async {
    isDataLoading(true);
    await HomeRepository().getDetailBook(id).then((value) {
      detailBook(value);
    }).catchError((e) {});
    isDataLoading(false);
  }
}
