import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../core/constants/user_data.dart';
import '../../data/Storage/for_you_data.dart';
import '../../data/models/home_model.dart';
import '../../data/repositories/homepage_repository.dart';
import '../screens/product_details.dart';

class RecommendedForYou extends StatefulWidget {
  final List<Product> recommendedForYou;

  const RecommendedForYou({super.key, required this.recommendedForYou});

  @override
  State<RecommendedForYou> createState() => _RecommendedForYouState();
}

class _RecommendedForYouState extends State<RecommendedForYou> {
  final HomePageRepository _homePageRepository = HomePageRepository();
  Future<void> onProductViewed(int userId, int productId) async {
    await _homePageRepository.logUserActivity(userId, productId, 'view');
  }

  @override
  Widget build(BuildContext context) {
    return widget.recommendedForYou.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              SizedBox(
                height: Get.height * 0.20,
                child: ListView.builder(
                  scrollDirection:
                      Axis.horizontal, // Enable horizontal scrolling
                  padding: const EdgeInsets.all(8.0),
                  itemCount: widget.recommendedForYou.length,
                  itemBuilder: (context, index) {
                    final product = productList[index];
                    return GestureDetector(
                      onTap: () async {
                        await onProductViewed(
                            userId,
                            widget.recommendedForYou[index]
                                .productId); // Navigate to product detail page or perform any action
                        Get.to(() => ProductDetailPage(
                            product: widget.recommendedForYou[index]));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 8.0), // Add margin between items
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            Expanded(
                              flex: 6,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(7),
                                ),
                                child: Image.asset(
                                  product['productImage'],
                                  fit: BoxFit.cover,
                                  width:
                                      150, // Adjust width for horizontal view
                                  height:
                                      150, // Adjust height for horizontal view
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Product Name
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      widget
                                          .recommendedForYou[index].productName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 4),

                                  // Pricing Information
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        // Sell Price
                                        Text(
                                          "Rs.${widget.recommendedForYou[index].sellPrice.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        // Normal Price (with strikethrough)
                                        Text(
                                          "Rs.${widget.recommendedForYou[index].normalPrice.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
