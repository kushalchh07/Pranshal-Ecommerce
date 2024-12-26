import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomeBrands extends StatefulWidget {
  const HomeBrands({super.key});

  @override
  State<HomeBrands> createState() => _HomeBrandsState();
}

class _HomeBrandsState extends State<HomeBrands> {
  List<Map<String, dynamic>> brandList = [
    {
      "name": "Nike",
      "image": "assets/images/b5.jpeg",
    },
    {
      "name": "Puma",
      "image": "assets/images/b8.jpeg",
    },
    {
      "name": "New Balance",
      "image": "assets/images/s6.jpg",
    },
    {
      "name": "Vans",
      "image": "assets/images/s9.jpg",
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
              itemCount: brandList.length,
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
                            image: AssetImage(brandList[index]["image"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        brandList[index]["name"],
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
