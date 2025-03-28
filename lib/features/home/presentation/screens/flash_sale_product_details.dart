import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';
import 'package:pranshal_ecommerce/core/constants/user_data.dart';
import 'package:pranshal_ecommerce/features/home/data/models/home_model.dart';

import '../../../cart/data/models/cart_model.dart';
import '../../../cart/presentation/blocs/cart_bloc/cart_bloc.dart';
import '../../../cart/presentation/blocs/cart_bloc/cart_event.dart';

class FlashSaleProductDetails extends StatefulWidget {
  final FlashSaleProduct? product;

  const FlashSaleProductDetails({Key? key, this.product}) : super(key: key);

  @override
  _FlashSaleProductDetailsState createState() => _FlashSaleProductDetailsState();
}

class _FlashSaleProductDetailsState extends State<FlashSaleProductDetails> {
  @override
  void initState() {
    super.initState();
  }

  /// Adds the current product to the cart by dispatching an AddToCartEvent
  /// with the product details to the CartBloc.
  void addtocart(Product product) {}

  void toggleWishlistStatus() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product!.productName,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.product!.productThumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Product Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    widget.product!.productName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Brand Name
                  Text(
                    "Brand: ${widget.product!.brandName}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Category
                  Text(
                    "Category: ${widget.product!.categoryName}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description
                  const Text(
                    "Description:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.product!.productDescription,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  // Pricing
                  Row(
                    children: [
                      Text(
                        "Rs.${widget.product!.sellPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (widget.product!.normalPrice !=
                          widget.product!.sellPrice)
                        Text(
                          "Rs. ${widget.product!.normalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available Quantity: ${widget.product!.totalProductCount}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.inventory,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Buttons for Add to Cart and Wishlist
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor2,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Add to Cart",
                            style: const TextStyle(
                                fontSize: 16, color: whiteColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor4,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: toggleWishlistStatus,
                          child: const Text(
                            "Buy Now.",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
