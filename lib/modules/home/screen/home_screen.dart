import 'dart:io';

import 'package:book_app/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
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
                  Platform.isIOS ? CupertinoIcons.search : Icons.search,
                  color: Colors.black54,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {},
                    autofocus: false,
                    decoration:
                        const InputDecoration.collapsed(hintText: "Search"),
                    cursorColor: primaryColor,
                  ),
                ),
                Icon(
                  Platform.isIOS
                      ? CupertinoIcons.slider_horizontal_3
                      : Icons.menu_rounded,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
          const Divider(thickness: 1, indent: 16, endIndent: 16),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  padding: const EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryGrayColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: whiteColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Judul Buku",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text("Penulis"),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Platform.isIOS
                              ? CupertinoIcons.heart
                              : Icons.favorite,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
