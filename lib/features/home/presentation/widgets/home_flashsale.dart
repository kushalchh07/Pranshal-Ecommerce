import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/features/home/presentation/screens/flash_sale_product_details.dart';
import 'package:pranshal_ecommerce/features/home/presentation/screens/product_details.dart';

import '../../../../core/constants/colors.dart';
import '../../data/models/home_model.dart';

class HomeFlashSale extends StatefulWidget {
  final List<FlashSaleProduct> flashSale;
  const HomeFlashSale({super.key, required this.flashSale});

  @override
  State<HomeFlashSale> createState() => _HomeFlashSaleState();
}

class _HomeFlashSaleState extends State<HomeFlashSale> {
  List<Map<String, dynamic>> flashSaleList = [
    {
      "name": "Laptop",
      "image": "assets/images/p1.jpeg",
      "normalPrice": "1000",
      "sellPrice": "500"
    },
    {
      "name": "Cosmetics",
      "image": "assets/images/p2.jpeg",
      "normalPrice": "1000",
      "sellPrice": "500"
    },
    {
      "name": "MacBook Air",
      "image": "assets/images/p3.jpeg",
      "normalPrice": "1000",
      "sellPrice": "500"
    },
    {
      "name": "Sandles",
      "image": "assets/images/p4.jpeg",
      "normalPrice": "1000",
      "sellPrice": "500"
    },
    {
      "name": "Bags",
      "image": "assets/images/p5.jpeg",
      "normalPrice": "1000",
      "sellPrice": "500"
    },
    {
      "name": "Boots",
      "image": "assets/images/p6.jpeg",
      "normalPrice": "1000",
      "sellPrice": "500"
    },
    {
      "name": "Glasses",
      "image": "assets/images/p7.jpeg",
      "normalPrice": "1000",
      "sellPrice": "500"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return widget.flashSale.length > 0
        ? Column(
            children: [
              SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      widget.flashSale.length > 6 ? 6 : widget.flashSale.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // Navigate to product detail page or perform any action
                              Get.to(() => FlashSaleProductDetails(
                                  product: widget.flashSale[index]));
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      widget.flashSale[index].productThumbnail),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.flashSale[index].productName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          Text(
                            "Rs.${widget.flashSale[index].sellPrice}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                                fontSize: 12),
                          ),
                          Text(
                            "Rs.${widget.flashSale[index].normalPrice}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: primaryColor,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
