import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample product list (simulating cart items)
  List<Map<String, dynamic>> productList = [
    {
      "productName": "Men's Casual Shirt",
      "categoryName": "Men",
      "brandName": "H&M",
      "productImage": "assets/images/b1.jpeg",
      "normalPrice": 25.99,
      "sellPrice": 19.99,
      "isChecked": false,
      "quantity": 1,
    },
    {
      "productName": "Women's Maxi Dress",
      "categoryName": "Women",
      "brandName": "Zara",
      "productImage": "assets/images/b1.jpeg",
      "normalPrice": 49.99,
      "sellPrice": 39.99,
      "isChecked": false,
      "quantity": 1,
    },
  ];

  bool selectAll = false; // State to control "Select All" checkbox

  // Method to toggle "Select All" checkbox
  void _toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (var product in productList) {
        product['isChecked'] = selectAll;
      }
    });
  }

  // Method to toggle individual product checkbox
  void _toggleProductSelection(int index, bool? value) {
    setState(() {
      productList[index]['isChecked'] = value ?? false;
      selectAll = productList.every((product) => product['isChecked']);
    });
  }

  // Method to increase the quantity of a product
  void _increaseQuantity(int index) {
    setState(() {
      productList[index]['quantity']++;
    });
  }

  // Method to decrease the quantity of a product
  void _decreaseQuantity(int index) {
    setState(() {
      if (productList[index]['quantity'] > 1) {
        productList[index]['quantity']--;
      }
    });
  }

  // Calculate the total price of selected products
  double _calculateTotalPrice() {
    return productList.fold(
      0.0,
      (sum, product) =>
          sum +
          (product['isChecked']
              ? product['sellPrice'] * product['quantity']
              : 0),
    );
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Checkbox to select product
                      Checkbox(
                        value: product['isChecked'],
                        onChanged: (value) =>
                            _toggleProductSelection(index, value),
                      ),
                      // Product Image
                      Image.asset(
                        product['productImage'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 16),
                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['productName'],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product['categoryName'],
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${product['sellPrice']}',
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
                                onPressed: () => _decreaseQuantity(index),
                                icon: const Icon(Icons.remove_circle_outline),
                                color: primaryColor,
                              ),
                              Text(
                                '${product['quantity']}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                onPressed: () => _increaseQuantity(index),
                                icon: const Icon(Icons.add_circle_outline),
                                color: primaryColor,
                              ),
                            ],
                          ),
                          Text(
                            "Quantity",
                            style: TextStyle(fontSize: 14, color: primaryColor),
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
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Select All Checkbox
                    const SizedBox(
                      width: 10,
                    ),
                    Checkbox(
                      value: selectAll,
                      onChanged: _toggleSelectAll,
                    ),
                    const Text(
                      "All",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),

                    // Total Price
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Total: \$${_calculateTotalPrice().toStringAsFixed(2)}",
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
                            // padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: _calculateTotalPrice() > 0
                              ? () {
                                  // Handle checkout logic
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
      ),
    );
  }
}
