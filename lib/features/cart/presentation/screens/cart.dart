import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor4,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          "My Cart",
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Text('cart Screen'),
      ),
    );
  }
}
