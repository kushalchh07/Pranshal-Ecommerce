import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/features/home/presentation/screens/flash_sale_product_details.dart';

import '../../../../core/constants/colors.dart';
import '../../data/models/home_model.dart';

class HomeFlashSale extends StatefulWidget {
  final List<FlashSaleProduct> flashSale;
  const HomeFlashSale({super.key, required this.flashSale});

  @override
  State<HomeFlashSale> createState() => _HomeFlashSaleState();
}

class _HomeFlashSaleState extends State<HomeFlashSale>
    with TickerProviderStateMixin {
  // Animation controllers for the confetti effect
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    // Make sure we have at least one item to avoid empty list issues
    int itemCount = widget.flashSale.isNotEmpty
        ? (widget.flashSale.length > 6 ? 6 : widget.flashSale.length)
        : 0;

    // Initialize controllers for each flash sale item
    _controllers = List.generate(
      itemCount,
      (index) => AnimationController(
        duration:
            Duration(milliseconds: 1500 + (index * 300)), // Staggered durations
        vsync: this,
      )..repeat(reverse: true),
    );

    // Create animations for each controller
    _animations = _controllers.map((controller) {
      return CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      );
    }).toList();

    // Start animations with slight delay between each
    if (_controllers.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        for (int i = 0; i < _controllers.length; i++) {
          Future.delayed(Duration(milliseconds: i * 150), () {
            if (mounted && _controllers[i].isAnimating) {
              _controllers[i].forward();
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flashSale.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Flash Sale Title with animated icon

        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                widget.flashSale.length > 6 ? 6 : widget.flashSale.length,
            itemBuilder: (context, index) {
              // Calculate discount percentage
              final discountPercentage = ((widget.flashSale[index].normalPrice -
                          widget.flashSale[index].sellPrice) /
                      widget.flashSale[index].normalPrice *
                      100)
                  .round();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Wrap in SizedBox to give the Stack definite dimensions
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Stack(
                        children: [
                          // Product Image (fills the entire stack space)
                          Positioned.fill(
                            child: GestureDetector(
                              onTap: () async {
                                Get.to(() => FlashSaleProductDetails(
                                    product: widget.flashSale[index]));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: NetworkImage(widget
                                        .flashSale[index].productThumbnail),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Discount Badge
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                "-$discountPercentage%",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),

                          // Confetti effect elements (animated)
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 120,
                      child: Text(
                        widget.flashSale[index].productName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "Rs.${widget.flashSale[index].sellPrice}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                          fontSize: 14),
                    ),
                    Text(
                      "Rs.${widget.flashSale[index].normalPrice}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Build confetti effect around the product image

  // Individual confetti dot

  // Flashing "Limited Time" text
}
