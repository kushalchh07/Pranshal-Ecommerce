import 'dart:developer';

import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pranshal_ecommerce/features/cart/data/models/cart_model.dart';
import 'package:pranshal_ecommerce/features/cart/data/repositories/order_repository.dart';
import 'package:pranshal_ecommerce/features/cart/presentation/blocs/cart_order_bloc/cart_order_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/user_data.dart';
import '../../../user profile/presentation/screens/order_list.dart';
import '../../data/models/order_cart_model.dart';
import 'package:http/http.dart' as http;

class CartCheckoutPage extends StatefulWidget {
  final List<int> selectedProductIds;
  final bool isSelectAll;
  final String totalAmount;
  final List<CartItem> cartItems;

  const CartCheckoutPage({
    super.key,
    required this.selectedProductIds,
    required this.isSelectAll,
    required this.totalAmount,
    required this.cartItems,
  });

  @override
  State<CartCheckoutPage> createState() => _CartCheckoutPageState();
}

class _CartCheckoutPageState extends State<CartCheckoutPage> {
  String? selectedPaymentMethod;
  String? selectedLocation;
  late CartOrderBloc _cartOrderBloc;

  final List<Map<String, String>> paymentMethods = [
    {"name": "eSewa", "image": "assets/images/esewa.png"},
    {"name": "Khalti", "image": "assets/images/khalti.png"},
    {"name": "Cash on Delivery", "image": "assets/images/cash.png"},
  ];

  @override
  void initState() {
    super.initState();
    _cartOrderBloc = CartOrderBloc(OrderRepository());
  }

  @override
  void dispose() {
    _cartOrderBloc.close(); // Don't forget to close the bloc when done
    super.dispose();
  }

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

  void _confirmPurchase() {
    if (selectedPaymentMethod != null && selectedLocation != null) {
      if (selectedPaymentMethod == "eSewa") {
        log("Selected Method - eSewa");
        payEsewa();
      } else {
        log("Selected Method - ${selectedPaymentMethod}");
        if (widget.isSelectAll) {
          log("Placing full cart order");
          _cartOrderBloc.add(
            PlaceFullCartOrder(
              userId: userId,
              paymentMethod: selectedPaymentMethod ?? "Cash on Delivery",
              deliveryLocation: selectedLocation ?? "Pokhara",
            ),
          );
        } else {
          log("Placing selected cart order with IDs: ${widget.selectedProductIds}");
          _cartOrderBloc.add(
            PlaceSelectedCartOrder(
              userId: userId,
              productIds: widget.selectedProductIds,
              paymentMethod: selectedPaymentMethod ?? "Cash on Delivery",
              deliveryLocation: selectedLocation ?? "Pokhara",
            ),
          );
        }
      }
    } else {
      // Show error message if payment method or location is not selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select both payment method and location'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  payEsewa() {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          //test ko lai
          clientId: 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R',
          secretId: 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
        ),
        esewaPayment: EsewaPayment(
          productId: 1.toString(),
          productName: "Cart Items",
          productPrice: widget.totalAmount,
          callbackUrl: '',
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) async {
          debugPrint(":::SUCCESS::: => $data");
          verifyTransactionStatus(data);
        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
  }

  void verifyTransactionStatus(EsewaPaymentSuccessResult result) async {
    Map data = result.toJson();

    var response = await callVerificationApi(data['refId']);
    print("The Response Is: ${response.body}");
    print("The Response Status Code Is: ${response.statusCode}");

    if (response.statusCode.toString() == "200") {
      if (widget.isSelectAll) {
        _cartOrderBloc.add(
          PlaceFullCartOrder(
            userId: userId,
            paymentMethod: selectedPaymentMethod ?? "Cash on Delivery",
            deliveryLocation: selectedLocation ?? "Pokhara",
          ),
        );
      } else {
        _cartOrderBloc.add(
          PlaceSelectedCartOrder(
            userId: userId,
            productIds: widget.selectedProductIds,
            paymentMethod: selectedPaymentMethod ?? "Cash on Delivery",
            deliveryLocation: selectedLocation ?? "Pokhara",
          ),
        );
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text('Verification Failed'),
              ));
    }
  }

  callVerificationApi(result) async {
    print("TxnRefd Id: " + result);

    var response = await http.get(
      Uri.parse("https://esewa.com.np/mobile/transaction?txnRefId=$result"),
      headers: {
        'Content-Type': 'application/json',
        'merchantSecret': 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
        'merchantId': 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R ',
      },
    );
    print("Call Verification Api: ${response.statusCode}");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cartOrderBloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Checkout')),
        body: BlocConsumer<CartOrderBloc, CartOrderState>(
          listener: (context, state) {
            log("Current state: $state");
            if (state is CartOrderSuccess) {
              _showSuccessDialog();
            } else if (state is CartOrderFailure) {
              _showErrorDialog("Error Occurred While Purchasing");
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text("Select Location",
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
                      SizedBox(height: 20),
                      const Text(
                        "Order Details:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Divider(color: Colors.grey.shade400),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Product Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "Quantity",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "Price",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "Total",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey.shade400),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.cartItems.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${widget.cartItems[index].productName}"),
                                    Text("${widget.cartItems[index].quantity}"),
                                    Text(
                                        "${widget.cartItems[index].sellPrice}"),
                                    Text(
                                        "${widget.cartItems[index].sellPrice * widget.cartItems[index].quantity}"),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Divider(color: Colors.grey.shade400),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text(
                          "Total Amount: ${widget.totalAmount}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ]),
                      SizedBox(height: 20),
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
                          child: Text('Confirm Purchase'),
                        ),
                      ),
                    ],
                  ),
                ),
                // Show loading indicator when the state is CartOrderLoading
                if (state is CartOrderLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: primaryColor2,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Order Placed Successfully"),
          content: Text("Your order has been placed successfully."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Get.offAll(() => const OrderListScreen());
              },
            ),
          ],
        );
      },
    );
  }

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
