import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({super.key});

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  List<Map<String, dynamic>> categoryList = [
    {
      "name": "Fashoin",
      "image": "assets/images/s1.jpg",
    },
    {
      "name": "Clarks",
      "image": "assets/images/s2.jpg",
    },
    {
      "name": "Computer",
      "image": "assets/images/s3.jpg",
    },
    {
      "name": "fashion",
      "image": "assets/images/s4.jpg",
    },
    {
      "name": "MoterCycle Club",
      "image": "assets/images/s5.jpg",
    },
    {
      "name": "New Balance.",
      "image": "assets/images/s6.jpg",
    },
    {
      "name": "Tiffany Co..",
      "image": "assets/images/s7.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.12,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.pink,
                          image: DecorationImage(
                            image: AssetImage(categoryList[index]["image"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        categoryList[index]["name"],
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
