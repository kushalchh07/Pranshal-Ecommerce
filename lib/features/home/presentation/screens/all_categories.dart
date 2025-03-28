import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../core/constants/colors.dart';
import '../../data/Storage/categories_data.dart';
import '../../data/models/home_model.dart';

class AllCategories extends StatefulWidget {
  final List<Category> categories;
  const AllCategories({super.key, required this.categories});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Categories",
          style: TextStyle(color: primaryColor),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount:
              widget.categories.length, // Dynamically show all categories
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row
            crossAxisSpacing: 10, // Horizontal spacing between items
            mainAxisSpacing: 10, // Vertical spacing between items
            childAspectRatio: 1, // Keep items square (1:1 aspect ratio)
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: Get.height * 0.16, // Adjust dynamically
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor),
                    borderRadius:
                        BorderRadius.circular(7), // Max 7 border radius
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.categories[index].categoryThumbnail),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    widget.categories[index].categoryName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
