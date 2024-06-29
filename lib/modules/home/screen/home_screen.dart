import 'package:book_app/common/constant.dart';
import 'package:book_app/modules/home/controller/home_controller.dart';
import 'package:book_app/modules/liked/controller/liked_book_controller.dart';
import 'package:book_app/modules/liked/screen/detail_liked_book_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => controller.isDataLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : Column(
                  children: [
                    SearchBook(
                      controller: controller,
                    ),
                    const Divider(thickness: 1, indent: 16, endIndent: 16),
                    ListBook(controller: controller)
                  ],
                ),
        ),
      ),
    );
  }
}

//This widget is for search the books by name
class SearchBook extends StatelessWidget {
  const SearchBook({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.black54,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                controller.searchText = value;
              },
              autofocus: false,
              decoration: const InputDecoration.collapsed(hintText: "Search"),
              cursorColor: primaryColor,
            ),
          ),
          Icon(
            Icons.menu_rounded,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}

// This widget is for showing the list of the books
class ListBook extends StatelessWidget {
  const ListBook({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final LikedBookController likedBookController =
        Get.put(LikedBookController());
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final book = controller.book.results![index];
          return Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            padding: const EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height / 8,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: primaryGrayColor,
            ),
            child: InkWell(
              onTap: () {
                Get.to(
                  () => const DetailLikedBookScreen(),
                  arguments: book.id,
                );
              },
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: book.formats!.imageJpeg ?? '',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          // margin: const EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width / 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
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
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.filteredBooks[index].title}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(controller.filteredBooks[index].authors
                                ?.map((author) => author.name)
                                .join(', ') ??
                            ''),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (likedBookController.likedBooks.contains(book)) {
                        likedBookController.unlikeBooks(book);
                      } else {
                        likedBookController.likeBooks(book);
                      }
                    },
                    icon: Obx(() => Icon(
                          likedBookController.likedBooks.contains(book)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: likedBookController.likedBooks.contains(book)
                              ? Colors.red
                              : Colors.black,
                        )),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
        itemCount: controller.filteredBooks.length,
      ),
    );
  }
}
