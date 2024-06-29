import 'package:book_app/modules/home/models/result.dart';
import 'package:get/get.dart';

class LikedBookController extends GetxController {
  final RxList<Result> _likedBooks = RxList<Result>();

  List<Result> get likedBooks => _likedBooks;

  void likeBooks(Result book) {
    _likedBooks.add(book);
    update();
  }

  void unlikeBooks(Result book) {
    _likedBooks.remove(book);
    update();
  }
}
