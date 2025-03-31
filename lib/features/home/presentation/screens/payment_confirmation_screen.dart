import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';
import 'package:pranshal_ecommerce/features/home/presentation/screens/homepage.dart';
import 'package:pranshal_ecommerce/features/user%20profile/presentation/screens/order_list.dart';
import '../../../../core/constants/user_data.dart';
import '../../../cart/data/models/order_cart_model.dart';
import '../../data/models/home_model.dart';
import '../blocs/order_bloc/order_bloc.dart';
import 'map_location_picker.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  final Product product;
  final int quantity;
  final double totalAmount;

  const PaymentConfirmationScreen(
      {super.key,
      required this.product,
      required this.quantity,
      required this.totalAmount});

  @override
  _PaymentConfirmationScreenState createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  String? selectedPaymentMethod;
  String? selectedLocation;

  final List<Map<String, String>> paymentMethods = [
    {"name": "eSewa", "image": "assets/images/esewa.png"},
    {"name": "Khalti", "image": "assets/images/khalti.png"},
    {"name": "Cash on Delivery", "image": "assets/images/cash.png"},
  ];

  void _selectLocation() async {
    // Mocking location selection, replace with Google Places API if needed
    List<String> locations = ["Kathmandu", "Pokhara", "Lalitpur", "Bhaktapur"];

    String? location = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Wrap(
            children: locations.map((loc) {
              return ListTile(
                title: Text(loc),
                onTap: () => Navigator.pop(context, loc),
              );
            }).toList(),
          ),
        );
      },
    );

    if (location != null) {
      setState(() {
        selectedLocation = location;
      });
    }
  }

  void _openMapPicker() async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapLocationPicker()),
    );

    if (selectedLocation != null) {
      setState(() {
        this.selectedLocation = selectedLocation["address"];
      });
    }
  }

  void _confirmPurchase() {
    if (selectedPaymentMethod != null && selectedLocation != null) {
      final order = Order(
        userId: userId,
        totalAmount: widget.product.sellPrice, // Example total
        paymentMethod: selectedPaymentMethod!,
        deliveryLocation: selectedLocation!,
        items: [
          OrderItem(
              productId: widget.product.productId,
              quantity: widget.quantity,
              price: widget.product.sellPrice),
        ],
      );
      log(order.toJson().toString());

      // Trigger the OrderBloc event
      context.read<OrderBloc>().add(PlaceSingleOrder(order));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Order", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            // Show success dialog
            _showSuccessDialog();
          } else if (state is OrderFailure) {
            // Show error dialog with the error message
            _showErrorDialog("Error Occured While Purchasing");
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Main content
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Location Selection
                    Text("Select Location",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: _selectLocation,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedLocation ??
                                  "Choose your delivery location",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: selectedLocation != null
                                      ? Colors.black
                                      : Colors.grey),
                            ),
                            Icon(Icons.location_on, color: primaryColor2),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Payment Method Selection
                    const Text("Select Payment Method",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Column(
                      children: paymentMethods.map((method) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedPaymentMethod = method["name"];
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedPaymentMethod == method["name"]
                                    ? primaryColor2
                                    : Colors.grey.shade300,
                                width: selectedPaymentMethod == method["name"]
                                    ? 2
                                    : 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: selectedPaymentMethod == method["name"]
                                  ? primaryColor2.withOpacity(0.1)
                                  : Colors.white,
                            ),
                            child: Row(
                              children: [
                                Image.asset(method["image"]!,
                                    width: 40, height: 40),
                                SizedBox(width: 15),
                                Text(method["name"]!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Spacer(),
                                if (selectedPaymentMethod == method["name"])
                                  Icon(Icons.check_circle,
                                      color: primaryColor2),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Spacer(),

                    // Purchase Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedPaymentMethod == null
                              ? Colors.grey
                              : primaryColor2,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: selectedPaymentMethod == null
                            ? null
                            : _confirmPurchase,
                        child: const Text("Purchase",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),

              // Loading Overlay
              if (state is OrderLoading)
                Container(
                  color: Colors.black
                      .withOpacity(0.3), // Transparent black background
                  child: const Center(
                    child: CupertinoActivityIndicator(radius: 20),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // Show success dialog
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Order Placed Successfully"),
          content: Text("Your order has been placed successfully."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Get.offAll(() => const OrderListScreen());
              },
            ),
          ],
        );
      },
    );
  }

  // Show error dialog
  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Order Failed"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
