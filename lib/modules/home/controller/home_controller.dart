import 'package:book_app/common/constant.dart';
import 'package:book_app/modules/home/models/book.dart';
import 'package:book_app/modules/home/models/result.dart';
import 'package:book_app/modules/home/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeController extends GetxController {
  final book = Book().obs;
  final listBook = <Result>[].obs;

  final PagingController<String, Result> pagingController =
      PagingController(firstPageKey: baseUrl);
  var isDataLoading = false.obs;
  var searchText = ''.obs;
  var searchResults = <Result>[].obs;

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      getListofBook(pageKey);
    });

    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  void getListofBook(String pageKey) async {
    try {
      final book = await HomeRepository().getBookData(pageKey);
      final newItems = book.results ?? [];
      final nextPageKey = book.next;
      final isLastData = nextPageKey == null;
      if (isLastData) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void searchBooks() async {
    try {
      final response = await HomeRepository().searchBooks(searchText.value);
      searchResults.clear();
      searchResults.addAll(response.results ?? []);
    } catch (error) {
      error.toString();
    }
  }
}
