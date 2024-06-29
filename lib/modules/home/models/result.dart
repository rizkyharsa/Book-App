import 'package:book_app/modules/home/models/author.dart';
import 'package:book_app/modules/home/models/book.dart';
import 'package:book_app/modules/home/models/formats.dart';

class Result {
  int? id;
  String? title;
  List<Author>? authors;
  List<Author>? translators;
  List<String>? subjects;
  List<String>? bookshelves;
  List<Language>? languages;
  bool? copyright;
  MediaType? mediaType;
  Formats? formats;
  int? downloadCount;

  Result({
    this.id,
    this.title,
    this.authors,
    this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        authors: json["authors"] == null
            ? []
            : List<Author>.from(
                json["authors"]!.map((x) => Author.fromJson(x))),
        translators: json["translators"] == null
            ? []
            : List<Author>.from(
                json["translators"]!.map((x) => Author.fromJson(x))),
        subjects: json["subjects"] == null
            ? []
            : List<String>.from(json["subjects"]!.map((x) => x)),
        bookshelves: json["bookshelves"] == null
            ? []
            : List<String>.from(json["bookshelves"]!.map((x) => x)),
        languages: json["languages"] == null
            ? []
            : List<Language>.from(
                json["languages"]!.map((x) => languageValues.map[x]!)),
        copyright: json["copyright"],
        mediaType: mediaTypeValues.map[json["media_type"]]!,
        formats:
            json["formats"] == null ? null : Formats.fromJson(json["formats"]),
        downloadCount: json["download_count"],
      );
}
