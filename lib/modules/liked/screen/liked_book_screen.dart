import 'package:book_app/common/constant.dart';
import 'package:book_app/modules/liked/controller/liked_book_controller.dart';
import 'package:book_app/modules/liked/screen/detail_liked_book_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikedBookScreen extends GetView<LikedBookController> {
  const LikedBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Center(
            child: Text(
          "Liked Book",
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        )),
      ),
      body: SafeArea(
        child: Obx(() => controller.likedBooks.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/search.jpg",
                      scale: 8,
                    ),
                    const Text(
                      "Opps, You haven't like any books!",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              )
            : ListLikedBook(controller: controller)),
      ),
    );
  }
}

class ListLikedBook extends StatelessWidget {
  const ListLikedBook({
    super.key,
    required this.controller,
  });

  final LikedBookController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final book = controller.likedBooks[index];
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
                arguments: controller.likedBooks[index].id,
              );
            },
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      controller.likedBooks[index].formats!.imageJpeg ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      // margin: const EdgeInsets.all(8),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
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
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.likedBooks[index].title}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(controller.likedBooks[index].authors
                              ?.map((author) => author.name)
                              .join(', ') ??
                          ''),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (controller.likedBooks.contains(book)) {
                      controller.unlikeBooks(book);
                    } else {
                      controller.likeBooks(book);
                    }
                  },
                  icon: Obx(() => Icon(
                        controller.likedBooks.contains(book)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: controller.likedBooks.contains(book)
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
      itemCount: controller.likedBooks.length,
    );
  }
}
