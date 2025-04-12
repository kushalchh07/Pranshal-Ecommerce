// ignore_for_file: library_private_types_in_public_api

import 'dart:io'; // Import for platform check

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';
import 'package:pranshal_ecommerce/core/constants/user_data.dart';
import 'package:pranshal_ecommerce/features/home/presentation/blocs/review_bloc/review_bloc.dart';
import 'package:pranshal_ecommerce/features/home/presentation/blocs/review_bloc/review_state.dart';

import '../../../cart/data/models/cart_model.dart';
import '../../../cart/presentation/blocs/cart_bloc/cart_bloc.dart';
import '../../../cart/presentation/blocs/cart_bloc/cart_event.dart';
import '../../../cart/presentation/blocs/cart_bloc/cart_state.dart';
import '../../../internet/presentation/internet_lost_screen.dart';
import '../../data/models/home_model.dart';
import '../../data/models/review_model.dart';
import '../../data/repositories/review_repository.dart';
import '../blocs/review_bloc/review_event.dart';
import 'payment_confirmation_screen.dart';

class ProductDetailPage extends StatefulWidget {
  final Product? product;

  const ProductDetailPage({super.key, this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  int _quantity = 1; // Track selected quantity
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  double _rating = 5.0;
  bool _isSubmittingReview = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final ReviewBloc reviewBloc = ReviewBloc(ReviewRepository());

  @override
  void initState() {
    super.initState();
    reviewBloc.add(LoadReviews(widget.product!.productId));

    // Initialize animation controller for checkmark animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    // Listen to review bloc state changes
    reviewBloc.stream.listen((state) {
      if (state is ReviewSubmitting) {
        setState(() {
          _isSubmittingReview = true;
        });
      } else if (state is ReviewSubmitted) {
        setState(() {
          _isSubmittingReview = false;
        });
        _showSuccessDialog();
        // Clear the form
        _commentController.clear();
        setState(() {
          _rating = 5.0;
        });
        // Reload reviews
        reviewBloc.add(LoadReviews(widget.product!.productId));
      } else if (state is ReviewError) {
        setState(() {
          _isSubmittingReview = false;
        });
        // Show error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${state.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _ratingController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Show success dialog with animated checkmark
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // Start the animation
        _animationController.reset();
        _animationController.forward();

        // Auto-dismiss after animation completes
        Future.delayed(const Duration(milliseconds: 1500), () {
          FocusScope.of(context).unfocus();
          Navigator.of(context).pop();
        });

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 200,
            width: 200,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated checkmark
                ScaleTransition(
                  scale: _animation,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Review Submitted!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
      shape: const RoundedRectangleBorder(
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
          title: const Text("Confirm Purchase"),
          message: StatefulBuilder(
            builder: (context, setState) =>
                _buildBottomSheetContent(context, setState),
          ),
          cancelButton: CupertinoActionSheetAction(
            child: const Text("Cancel"),
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
              const Text("Quantity",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() => _quantity--);
                      }
                    },
                  ),
                  Text("$_quantity", style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
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
                _confirmPurchase(widget.product!, _quantity,
                    widget.product!.sellPrice * _quantity);
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
  void _confirmPurchase(Product product, int quantity, double totalAmount) {
    Get.to(() => PaymentConfirmationScreen(
          product: product,
          quantity: quantity,
          totalAmount: totalAmount,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
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
                    const Text("Description:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(widget.product!.productDescription,
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),

                    // Pricing
                    Row(
                      children: [
                        Text(
                            "Rs.${widget.product!.sellPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                        const SizedBox(width: 10),
                        if (widget.product!.normalPrice !=
                            widget.product!.sellPrice)
                          Text(
                              "Rs. ${widget.product!.normalPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Buy Now Button
                    Row(
                      children: [
                        BlocConsumer<CartBloc, CartState>(
                          listener: (context, state) {
                            if (state is CartSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: greenColor,
                                    content: const Text(
                                      'Added to cart successfully!',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              );
                            } else if (state is CartError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Error: ${state.message}')),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is CartLoading) {
                              return Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor2,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16)),
                                  onPressed: () {},
                                  child: const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }
                            return Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor2,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16)),
                                onPressed: () {
                                  final cartItem = CartItem(
                                    userId: userId,
                                    productId: widget.product!.productId,
                                    productName: widget.product!.productName,
                                    productThumbnail:
                                        widget.product!.productThumbnail,
                                    productDescription:
                                        widget.product!.productDescription,
                                    normalPrice: widget.product!.normalPrice,
                                    sellPrice: widget.product!.sellPrice,
                                    discountPercentage: 10,
                                    discountedPrice: 0,
                                    quantity: 1,
                                  );
                                  context
                                      .read<CartBloc>()
                                      .add(AddToCartEvent(cartItem));
                                },
                                child: const Text(
                                  "Add to Cart",
                                  style: TextStyle(color: whiteColor),
                                ),
                              ),
                            );
                          },
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    // Submit review
                    const Text("Write a review",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),

                    const SizedBox(height: 10),

                    // Star Rating Bar
                    RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      maxRating: 5,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                    const SizedBox(height: 10), // Comment Field
                    TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        labelText: 'Your Comment',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),

                    // Submit Review Button with Loading Indicator
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor1,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: _isSubmittingReview
                            ? null
                            : () {
                                if (_commentController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Please enter a comment')));
                                  return;
                                }

                                final review = Review(
                                  productId: widget.product!.productId,
                                  userId: 1, // replace with actual user ID
                                  userName: userName, // or actual user
                                  comment: _commentController.text,
                                  rating: _rating,
                                );
                                reviewBloc.add(SubmitReview(review));
                              },
                        child: _isSubmittingReview
                            ? Platform.isIOS
                                ? const CupertinoActivityIndicator(
                                    color: Colors.white)
                                : const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                            : const Text(
                                "Submit Review",
                                style:
                                    TextStyle(fontSize: 16, color: whiteColor),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Display reviews
                    BlocBuilder<ReviewBloc, ReviewState>(
                      bloc: reviewBloc,
                      builder: (context, state) {
                        if (state is ReviewLoading) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is ReviewLoaded) {
                          // Calculate average rating
                          double averageRating = 0;
                          if (state.reviews.isNotEmpty) {
                            double totalRating = state.reviews
                                .fold(0, (sum, review) => sum + review.rating);
                            averageRating = totalRating / state.reviews.length;
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display reviews heading with average rating
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Customer Reviews",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  if (state.reviews.isNotEmpty)
                                    Row(
                                      children: [
                                        Text(
                                          "${averageRating.toStringAsFixed(1)}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber.shade800,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        RatingBarIndicator(
                                          rating: averageRating,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 16.0,
                                          direction: Axis.horizontal,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "(${state.reviews.length})",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Review List
                              if (state.reviews.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      "No reviews yet. Be the first to review!",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Column(
                                  children: state.reviews.map((review) {
                                    return Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor:
                                              primaryColor2.withOpacity(0.2),
                                          child: Text(
                                            review.userName.isNotEmpty
                                                ? review.userName[0]
                                                    .toUpperCase()
                                                : 'G',
                                            style: TextStyle(
                                              color: primaryColor2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        title: Row(
                                          children: [
                                            Text(
                                              review.userName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(width: 8),
                                            RatingBarIndicator(
                                              rating: review.rating,
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 16.0,
                                              direction: Axis.horizontal,
                                            ),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 4),
                                            Text(
                                              review.comment,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        isThreeLine: true,
                                      ),
                                    );
                                  }).toList(),
                                ),
                            ],
                          );
                        } else if (state is ReviewError) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 48,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Error: ${state.message}",
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      reviewBloc.add(LoadReviews(
                                          widget.product!.productId));
                                    },
                                    child: const Text("Retry"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
