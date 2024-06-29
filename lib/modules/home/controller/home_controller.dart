import 'package:book_app/modules/home/models/book.dart';
import 'package:book_app/modules/home/models/result.dart';
import 'package:book_app/modules/home/repository/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final Rx<Book> _books = Rx(Book());
  final RxString _searchText = ''.obs;
  // var book = Book().obs;
  // var listBook = <Result>[].obs;
  var isDataLoading = false.obs;

  Book get book => _books.value;
  String get searchText => _searchText.value;

  set searchText(String value) => _searchText.value = value;

  @override
  void onInit() {
    getBookList();
    super.onInit();
  }

  void getBookList() async {
    isDataLoading(true);
    try {
      final book = await HomeRepository().getBookData();
      _books.value = book;

      // await HomeRepository().getListofBook().then((value) {
      //   listBook.assignAll(value);
      // }).catchError((e) {});
    } catch (e) {
      print(e.toString());
    }
    isDataLoading(false);
  }

  List<Result> get filteredBooks {
    if (searchText.isEmpty) {
      return book.results ?? [];
    } else {
      return book.results
              ?.where((result) =>
                  result.title
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false)
              .toList() ??
          [];
    }
  }
}
