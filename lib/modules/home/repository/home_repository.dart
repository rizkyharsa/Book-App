import 'package:book_app/common/constant.dart';
import 'package:book_app/modules/home/models/book.dart';
import 'package:book_app/modules/home/models/result.dart';
import 'package:book_app/services/rest_services.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  Dio get dio => RestService().dio;
  String? nextPage;

  Future<Book> getBookData([String? pageKey]) async {
    try {
      final url = pageKey ?? baseUrl;
      final response = await dio.get(url);
      return Book.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Result> getDetailBook(var id) async {
    try {
      final response = await dio.get("$baseUrl/$id");
      return Result.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Book> searchBooks(String query) async {
    try {
      final encodedQuery = Uri.encodeQueryComponent(query.toLowerCase());
      final response = await dio.get('$baseUrl/?search=$encodedQuery');
      return Book.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
