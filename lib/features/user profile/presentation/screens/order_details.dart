import 'package:flutter/material.dart';
import 'package:pranshal_ecommerce/features/cart/data/models/order_cart_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderGet order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title:
            Text("Order #${order.orderId} Details", style: const TextStyle()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Order Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.date_range, color: Colors.blueAccent),
              title: const Text("Order Date"),
              subtitle: Text(order.orderDate),
            ),
            ListTile(
              leading:
                  const Icon(Icons.monetization_on, color: Colors.blueAccent),
              title: const Text("Total Amount"),
              subtitle: Text("\Rs.${order.totalAmount.toStringAsFixed(2)}"),
            ),
            ListTile(
              leading: const Icon(Icons.payment, color: Colors.blueAccent),
              title: const Text("Payment Method"),
              subtitle: Text(order.paymentMethod),
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.blueAccent),
              title: const Text("Delivery Location"),
              subtitle: Text(order.deliveryLocation),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.blueAccent),
              title: const Text("Order Status"),
              subtitle: Text(order.orderStatus),
            ),
          ],
        ),
      ),
    );
  }
}
