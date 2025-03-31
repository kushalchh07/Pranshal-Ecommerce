import 'package:flutter/material.dart';
import 'package:pranshal_ecommerce/core/constants/colors.dart';

import 'map_location_picker.dart';

class PaymentConfirmationScreen extends StatefulWidget {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Purchase Successful!")),
      );
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Selection
            Text("Select Location",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            InkWell(
              onTap: _selectLocation,
              // onTap: _openMapPicker,
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
                      selectedLocation ?? "Choose your delivery location",
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
            Text("Select Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                        width: selectedPaymentMethod == method["name"] ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: selectedPaymentMethod == method["name"]
                          ? primaryColor2.withOpacity(0.1)
                          : Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset(method["image"]!, width: 40, height: 40),
                        SizedBox(width: 15),
                        Text(method["name"]!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Spacer(),
                        if (selectedPaymentMethod == method["name"])
                          Icon(Icons.check_circle, color: primaryColor2),
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
                onPressed:
                    selectedPaymentMethod == null ? null : _confirmPurchase,
                child: Text("Purchase",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
