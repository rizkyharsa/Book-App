import 'package:book_app/modules/home/models/result.dart';

class Book {
  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;

  Book({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        count: json["count"],
        next: json["next"] ?? '',
        previous: json["previous"] ?? '',
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
      );
}

enum Language { EN, ES }

final languageValues = EnumValues({"en": Language.EN, "es": Language.ES});

enum MediaType { TEXT }

final mediaTypeValues = EnumValues({"Text": MediaType.TEXT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
