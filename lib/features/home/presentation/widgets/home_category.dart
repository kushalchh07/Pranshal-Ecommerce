import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';
import 'package:pranshal_ecommerce/features/home/data/models/home_model.dart';

import '../../data/Storage/categories_data.dart';

class HomeCategory extends StatefulWidget {
  final List<Category> categories;
  const HomeCategory({super.key, required this.categories});

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.14,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  widget.categories.length > 6 ? 6 : widget.categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: greyColor),
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            image: AssetImage(categoryList[index]["image"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.categories[index].categoryName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
