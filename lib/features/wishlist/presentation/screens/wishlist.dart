import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  // Simulating product data and loading state
  List<Map<String, dynamic>> productList = [
    {
      "productName": "Men's Casual Shirt",
      "categoryName": "Men",
      "brandName": "H&M",
      "productImage": "assets/images/b1.jpeg",
      "description": "A comfortable and stylish casual shirt.",
      "normalPrice": 25.99,
      "sellPrice": 19.99,
      "isAddedToCart": false,
      "isAddedToWishlist": false,
      "productQuantity": 10,
    },
    {
      "productName": "Women's Maxi Dress",
      "categoryName": "Women",
      "brandName": "Zara",
      "productImage": "assets/images/b1.jpeg",
      "description": "Elegant maxi dress for special occasions.",
      "normalPrice": 49.99,
      "sellPrice": 39.99,
      "isAddedToCart": false,
      "isAddedToWishlist": false,
      "productQuantity": 5,
    },
  ];

  bool isLoading = true; // State to control shimmer and list display

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // Simulates loading delay
  Future<void> _loadProducts() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2)); // Simulate network call
    setState(() {
      isLoading = false;
    });
  }

  // Adds a single product to cart
  void _addToCart(int index) {
    setState(() {
      productList[index]['isAddedToCart'] = true;
    });
  }

  // Adds all products to the cart
  void _addAllToCart() {
    setState(() {
      for (var product in productList) {
        product['isAddedToCart'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor4,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          "My Wishlist",
          style: TextStyle(color: myBlack, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.search,
              color: primaryColor,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: _loadProducts,
        child: isLoading
            ? _buildShimmerEffect() // Show shimmer while loading
            : _buildProductList(), // Show list when loaded
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(bottom: 50.0, right: 15, left: 20, top: 10),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
            onPressed: _addAllToCart,
            child: Text(
              'ADD ALL TO CART',
              style: TextStyle(
                  fontSize: Get.height * 0.015,
                  fontWeight: FontWeight.bold,
                  color: whiteColor),
            ),
          ),
        ),
      ),
    );
  }

  // Builds the shimmer effect when loading
  Widget _buildShimmerEffect() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 5, // Number of shimmer items
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 14,
                        width: 150,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  height: 30,
                  width: 80,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Builds the product list
  Widget _buildProductList() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
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
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
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
                // Add to Cart Button
                ElevatedButton(
                  onPressed:
                      product['isAddedToCart'] ? null : () => _addToCart(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    disabledBackgroundColor: Colors.grey,
                  ),
                  child: Text(
                    product['isAddedToCart'] ? 'Added' : 'Add to Cart',
                    style: const TextStyle(fontSize: 14, color: whiteColor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
