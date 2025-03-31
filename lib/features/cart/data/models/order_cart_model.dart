class Order {
  final int userId;
  final double totalAmount;
  final String paymentMethod;
  final String deliveryLocation;
  final List<OrderItem> items;

  Order({
    required this.userId,
    required this.totalAmount,
    required this.paymentMethod,
    required this.deliveryLocation,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "total_amount": totalAmount,
      "payment_method": paymentMethod,
      "delivery_location": deliveryLocation,
      "items": items.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderItem {
  final int productId;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
      "price": price,
    };
  }
}
class OrderGet {
  final int orderId;
  final double totalAmount;
  final String orderStatus;
  final String orderDate;
  final String paymentMethod;
  final String deliveryLocation;

  OrderGet({
    required this.orderId,
    required this.totalAmount,
    required this.orderStatus,
    required this.orderDate,
    required this.paymentMethod,
    required this.deliveryLocation,
  });

  factory OrderGet.fromJson(Map<String, dynamic> json) {
    return OrderGet(
      orderId: json['order_id'],
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      orderStatus: json['order_status'] ?? 'pending',
      orderDate: json['order_date'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      deliveryLocation: json['delivery_location'] ?? '',
    );
  }
}
