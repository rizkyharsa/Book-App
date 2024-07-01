import 'package:book_app/common/constant.dart';
import 'package:book_app/modules/home/controller/detail_book_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailLikedBookScreen extends GetView<DetailBookController> {
  const DetailLikedBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: primaryColor,
        title: const Text(
          "Book Detail",
          style: TextStyle(color: whiteColor),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => controller.isDataLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              )
            : Column(
                children: [
                  SizedBox(height: height * .04, width: width),
                  DetailBook(
                      height: height, width: width, controller: controller),
                ],
              ),
      ),
    );
  }
}

class DetailBook extends StatelessWidget {
  const DetailBook({
    super.key,
    required this.height,
    required this.width,
    required this.controller,
  });

  final double height;
  final double width;
  final DetailBookController controller;

  @override
  Widget build(BuildContext context) {
    var books = controller.detailBook.value;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CachedNetworkImage(
              imageUrl: books.formats?.imageJpeg ?? '',
              imageBuilder: (context, imageProvider) {
                return Container(
                  // margin: const EdgeInsets.all(8),
                  height: height * .15,
                  width: width * .25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: primaryGrayColor),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              placeholder: (context, url) {
                return const SizedBox.shrink();
              },
              errorWidget: (context, url, error) {
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 18),
            Text(
              "${books.title}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              books.authors?.map((author) => author.name).join(', ') ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(height: 24),
            Container(
              height: height / 14,
              width: width * .6,
              decoration: BoxDecoration(
                color: fourthColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Language",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(books.languages
                                  ?.map((language) => language.name)
                                  .join(', ') ==
                              "EN"
                          ? "English"
                          : "Spanish")
                    ],
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                    color: primaryColor,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Download",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${books.downloadCount}"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Bookshelves",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: primaryColor),
                    ),
                    Text(books.bookshelves
                            ?.map((bookshelve) => bookshelve)
                            .join('\n') ??
                        ''),
                    const SizedBox(height: 12),
                    const Text(
                      "Subjects",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: primaryColor),
                    ),
                    Text(books.subjects
                            ?.map((subject) => subject)
                            .join(', ')
                            .replaceAll('-- ', '') ??
                        ''),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
