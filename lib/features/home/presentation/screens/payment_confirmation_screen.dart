import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  const PaymentConfirmationScreen({super.key});

  @override
  State<PaymentConfirmationScreen> createState() => _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Payment Confirmation"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
    );
  }
}