import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';
import 'package:pranshal_ecommerce/core/constants/user_data.dart';

import '../../../home/presentation/screens/shimmer.dart';
import '../blocs/cart_bloc/cart_bloc.dart';
import '../blocs/cart_bloc/cart_event.dart';
import '../blocs/cart_bloc/cart_state.dart';
import 'cart_checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool selectAll = false; // State to control "Select All" checkbox
  Map<String, bool> selectedItems = {}; // Map to track selected items by ID
  Map<String, int> itemQuantities = {}; // Map to track quantities by ID

  // Method to toggle "Select All" checkbox for dynamic items
  void _toggleSelectAll(bool? value, List<dynamic> cartItems) {
    setState(() {
      selectAll = value ?? false;
      for (var item in cartItems) {
        selectedItems[item.cartId.toString()] = selectAll;
      }
    });
  }

  // Method to toggle individual product checkbox
  void _toggleProductSelection(
      String itemId, bool? value, List<dynamic> cartItems) {
    setState(() {
      selectedItems[itemId] = value ?? false;

      // Check if all items are selected to update selectAll state
      selectAll = cartItems
          .every((item) => selectedItems[item.cartId.toString()] == true);
    });
  }

  // Method to increase the quantity of a product
  void _increaseQuantity(String itemId) {
    setState(() {
      itemQuantities[itemId] = (itemQuantities[itemId] ?? 1) + 1;
    });
    // You can also dispatch an event to update the quantity in your backend
    // BlocProvider.of<CartBloc>(context).add(UpdateCartItemQuantityEvent(itemId, itemQuantities[itemId]!));
  }

  // Method to decrease the quantity of a product
  void _decreaseQuantity(String itemId) {
    setState(() {
      if ((itemQuantities[itemId] ?? 1) > 1) {
        itemQuantities[itemId] = (itemQuantities[itemId] ?? 1) - 1;
        // You can also dispatch an event to update the quantity in your backend
        // BlocProvider.of<CartBloc>(context).add(UpdateCartItemQuantityEvent(itemId, itemQuantities[itemId]!));
      }
    });
  }

  // Calculate the total price of selected products
  double _calculateTotalPrice(List<dynamic> cartItems) {
    double total = 0.0;
    for (var item in cartItems) {
      if (selectedItems[item.cartId.toString()] == true) {
        total += item.sellPrice * (itemQuantities[item.cartId.toString()] ?? 1);
      }
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(FetchCartEvent(userId));
  }

  // Initialize selections and quantities when cart items are loaded
  void _initializeCartItems(List<dynamic> cartItems) {
    if (selectedItems.isEmpty && itemQuantities.isEmpty) {
      for (var item in cartItems) {
        selectedItems[item.cartId.toString()] = false;
        itemQuantities[item.cartId.toString()] = item.quantity ?? 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor4,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          "My Cart",
          style: TextStyle(color: myBlack, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          // You can handle any state changes here if needed
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: ShimmerHome(),
            );
          }
          if (state is CartLoaded) {
            // Initialize selections and quantities for items
            _initializeCartItems(state.cartItems);

            return Column(
              children: [
                Expanded(
                  child: state.cartItems.isEmpty
                      ? const Center(child: Text("Your cart is empty"))
                      : ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = state.cartItems[index];
                            final itemId = item.cartId.toString();

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  // Checkbox to select product
                                  Checkbox(
                                    value: selectedItems[itemId] ?? false,
                                    onChanged: (value) =>
                                        _toggleProductSelection(
                                            itemId, value, state.cartItems),
                                  ),
                                  // Product Image - using network image if available
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: item.productThumbnail != null &&
                                            item.productThumbnail.isNotEmpty
                                        ? Image.network(
                                            item.productThumbnail,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(
                                                  Icons.image_not_supported);
                                            },
                                          )
                                        : const Icon(Icons.image_not_supported),
                                  ),
                                  const SizedBox(width: 16),
                                  // Product Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.productName ?? "Unknown Product",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Rs. ${item.sellPrice ?? 0.0}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Quantity Selector
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () =>
                                                _decreaseQuantity(itemId),
                                            icon: const Icon(
                                                Icons.remove_circle_outline),
                                            color: primaryColor,
                                          ),
                                          Text(
                                            '${itemQuantities[itemId] ?? 1}',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          IconButton(
                                            onPressed: () =>
                                                _increaseQuantity(itemId),
                                            icon: const Icon(
                                                Icons.add_circle_outline),
                                            color: primaryColor,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Quantity",
                                        style: TextStyle(
                                            fontSize: 14, color: primaryColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                // Bottom Section
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Select All Checkbox
                          const SizedBox(width: 10),
                          Checkbox(
                            value: selectAll,
                            onChanged: (value) =>
                                _toggleSelectAll(value, state.cartItems),
                          ),
                          const Text(
                            "All",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),

                          // Total Price
                          const SizedBox(width: 30),
                          Text(
                            "Total: ₹${_calculateTotalPrice(state.cartItems).toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          const Spacer(), // Checkout Button
                          SizedBox(
                            height: 45,
                            width: Get.width * 0.4,
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed:
                                    _calculateTotalPrice(state.cartItems) > 0
                                        ? () {
                                            // Handle checkout logic
                                            // You can get selected items using:
                                            final selectedCartItems = state
                                                .cartItems
                                                .where((item) =>
                                                    selectedItems[item.cartId
                                                        .toString()] ==
                                                    true)
                                                .toList();
                                            // Then process checkout with these items

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CartCheckoutPage(
                                                  selectedProductIds:
                                                      selectedCartItems
                                                          .map((item) =>
                                                              item.productId)
                                                          .toList(),
                                                  isSelectAll: selectAll,
                                                  totalAmount:
                                                      _calculateTotalPrice(
                                                              selectedCartItems)
                                                          .toString(),
                                                  cartItems: selectedCartItems,
                                                  // totalAmount: _calculateTotalPrice(
                                                  //     selectedCartItems),
                                                ),
                                              ),
                                            );
                                          }
                                        : null,
                                child: const Text(
                                  'Checkout',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: whiteColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is CartError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
