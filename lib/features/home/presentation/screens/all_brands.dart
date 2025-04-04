import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/features/home/presentation/screens/brand_wise_products.dart';

import '../../../../core/constants/colors.dart';
import '../../data/Storage/brands_data.dart';
import '../../data/Storage/categories_data.dart';
import '../../data/models/home_model.dart';

class AllBrands extends StatefulWidget {
  final List<Brand> homebrands;
  const AllBrands({super.key, required this.homebrands});

  @override
  State<AllBrands> createState() => _AllBrandsState();
}

class _AllBrandsState extends State<AllBrands> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Brands",
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
              widget.homebrands.length, // Dynamically show all categories
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row
            crossAxisSpacing: 10, // Horizontal spacing between items
            mainAxisSpacing: 10, // Vertical spacing between items
            childAspectRatio: 1, // Keep items square (1:1 aspect ratio)
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                log("tapp bhayo hai brand");
                Get.to(() => BrandWiseProducts(
                      brandId: widget.homebrands[index].brandId,
                      brandName: widget.homebrands[index].brandName,
                    ));
              },
              child: Column(
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
                            widget.homebrands[index].brandThumbnail),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Text(
                      widget.homebrands[index].brandName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
