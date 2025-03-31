// ignore_for_file: library_private_types_in_public_api

import 'dart:io'; // Import for platform check

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';

import '../../../internet/presentation/internet_lost_screen.dart';
import '../../data/models/home_model.dart';
import 'payment_confirmation_screen.dart';

class ProductDetailPage extends StatefulWidget {
  final Product? product;

  const ProductDetailPage({super.key, this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1; // Track selected quantity

  /// Displays the Bottom Sheet for the Buy Now process
  void showBuyNowBottomSheet(BuildContext context) {
    if (Platform.isAndroid) {
      _showAndroidBottomSheet(context);
    } else if (Platform.isIOS) {
      _showIOSBottomSheet(context);
    }
  }

  /// Android-specific bottom sheet
  void _showAndroidBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) =>
              _buildBottomSheetContent(context, setState),
        );
      },
    );
  }

  void _showIOSBottomSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Text("Confirm Purchase"),
          message: StatefulBuilder(
            builder: (context, setState) =>
                _buildBottomSheetContent(context, setState),
          ),
          cancelButton: CupertinoActionSheetAction(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
        );
      },
    );
  }

  /// Common bottom sheet UI
  Widget _buildBottomSheetContent(BuildContext context, StateSetter setState) {
    double totalPrice = widget.product!.sellPrice * _quantity;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Product Info
          ListTile(
            leading: Image.network(widget.product!.productThumbnail,
                width: 50, height: 50),
            title: Text(widget.product!.productName,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle:
                Text("Rs. ${widget.product!.sellPrice.toStringAsFixed(2)}"),
          ),

          // Quantity Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Quantity",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() => _quantity--);
                      }
                    },
                  ),
                  Text("$_quantity", style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      if (_quantity < widget.product!.totalProductCount) {
                        setState(() => _quantity++);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),

          // Total Price
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Rs. ${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ],
            ),
          ),

          // Confirm Purchase Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Navigator.pop(context);
                _confirmPurchase();
              },
              child: const Text("Confirm Purchase",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  /// Placeholder function for confirming the purchase
  void _confirmPurchase() {



    Get.to(() => const PaymentConfirmationScreen());
   
  }

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
                  Text(widget.product!.productName,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),

                  // Brand Name
                  Text("Brand: ${widget.product!.brandName}",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  SizedBox(height: 10),

                  // Category
                  Text("Category: ${widget.product!.categoryName}",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  SizedBox(height: 20),

                  // Description
                  Text("Description:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(widget.product!.productDescription,
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),

                  // Pricing
                  Row(
                    children: [
                      Text("Rs.${widget.product!.sellPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      SizedBox(width: 10),
                      if (widget.product!.normalPrice !=
                          widget.product!.sellPrice)
                        Text(
                            "Rs. ${widget.product!.normalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Buy Now Button
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor2,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16)),
                          onPressed: () {},
                          child: const Text("Add to Cart",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor4,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16)),
                          onPressed: () => showBuyNowBottomSheet(context),
                          child: const Text("Buy Now",
                              style: TextStyle(fontSize: 16)),
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
