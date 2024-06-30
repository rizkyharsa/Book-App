import 'package:book_app/common/constant.dart';
import 'package:book_app/modules/home/models/book.dart';
import 'package:book_app/modules/home/models/result.dart';
import 'package:book_app/services/rest_services.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  Dio get dio => RestService().dio;

  Future<Book> getBookData() async {
    try {
      final response = await dio.get(baseUrl);
      return Book.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
    // var res = await dio.get(baseUrl);
    // return Book.fromJson(res.data['data']);
  }

  Future<Result> getDetailBook(var id) async {
    try {
      final response = await dio.get("$baseUrl/$id");
      return Result.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Future<List<Result>> getListofBook() async {
  //   var res = await dio.get(baseUrl);
  //   if (res.statusCode == 200) {
  //     final List rawData = jsonDecode(jsonEncode(res.data));
  //     return rawData.map((e) => Result.fromJson(e)).toList();
  //   } else {
  //     return [];
  //   }
  // }

  // Future<List<Book>> getBookData() async {
  //   var res = await dio.get(baseUrl);
  //   final resData = res.data as List;
  //   return resData.map((json) => Book.fromJson(json)).toList();
  // }

  // try {
  //     final response = await dio.get(baseUrl);
  //     return Book.fromJson(response.data);
  //   } catch (e) {
  //     rethrow;
  //   }
}