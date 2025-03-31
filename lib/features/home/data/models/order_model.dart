// class Order {
//   final int userId;
//   final double totalAmount;
//   final String paymentMethod;
//   final String deliveryLocation;
//   final List<OrderItem> items;

//   Order({
//     required this.userId,
//     required this.totalAmount,
//     required this.paymentMethod,
//     required this.deliveryLocation,
//     required this.items,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "user_id": userId,
//       "total_amount": totalAmount,
//       "payment_method": paymentMethod,
//       "delivery_location": deliveryLocation,
//       "items": items.map((item) => item.toJson()).toList(),
//     };
//   }
// }

// class OrderItem {
//   final int productId;
//   final int quantity;
//   final double price;

//   OrderItem({
//     required this.productId,
//     required this.quantity,
//     required this.price,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "product_id": productId,
//       "quantity": quantity,
//       "price": price,
//     };
//   }
// }
