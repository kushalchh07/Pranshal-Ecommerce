import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';
import 'package:pranshal_ecommerce/features/home/data/models/home_model.dart';

import '../../data/Storage/brands_data.dart';

class HomeBrands extends StatefulWidget {
  final List<Brand> homebrands;
  const HomeBrands({super.key, required this.homebrands});

  @override
  State<HomeBrands> createState() => _HomeBrandsState();
}

class _HomeBrandsState extends State<HomeBrands> {
  @override
  Widget build(BuildContext context) {
    return widget.homebrands.length > 0
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.14,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.homebrands.length > 6
                        ? 6
                        : widget.homebrands.length,
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
                                  image: AssetImage(brandList[index]["image"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.homebrands[index].brandName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
