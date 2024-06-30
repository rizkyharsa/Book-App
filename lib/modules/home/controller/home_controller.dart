import 'package:book_app/common/constant.dart';
import 'package:book_app/modules/home/models/book.dart';
import 'package:book_app/modules/home/models/result.dart';
import 'package:book_app/modules/home/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeController extends GetxController {
  // final Rx<Book> _books = Rx(Book());
  final book = Book().obs;
  final listBook = <Result>[].obs;
  // final RxString _searchText = ''.obs;
  final PagingController<String, Result> pagingController =
      PagingController(firstPageKey: baseUrl);
  var isDataLoading = false.obs;
  var searchText = ''.obs;
  var searchResults = <Result>[].obs;

  // Book get book => _books.value;
  // String get searchText => _searchText.value;

  // set searchText(String value) => _searchText.value = value;

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      getListofBook(pageKey);
    });
    // getBookList();
    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  // void getBookList() async {
  //   isDataLoading(true);
  //   try {
  //     await HomeRepository().getListofBook().then((value) {
  //       listBook.addAll(value);
  //       nextUrl.value = HomeRepository().nextPage != null;
  //     }).catchError((e) {});
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   isDataLoading(false);
  // }

  // void nextPage() async {
  //   if (nextUrl.value) {
  //     isDataLoading(true);
  //     await HomeRepository().getNextPage().then((value) {
  //       listBook.addAll(value);
  //       nextUrl.value = HomeRepository().nextPage != null;
  //     });
  //     isDataLoading(false);
  //   }
  // }

  void getListofBook(String pageKey) async {
    try {
      // final bookData = await HomeRepository().getListofBook();
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
      searchResults.value = response.results ?? [];
      print('Search Results: ${searchResults.value}');
    } catch (error) {
      print(error);
    }
  }
}
