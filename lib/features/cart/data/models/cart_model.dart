class CartItem {
  final int? cartId;
  final int userId;
  final int productId;
  final String productName;
  final String productThumbnail;
  final String productDescription;
  final double normalPrice;
  final double sellPrice;
  final double discountPercentage;
  final double discountedPrice;
  final int quantity;

  CartItem({
    this.cartId,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.productThumbnail,
    required this.productDescription,
    required this.normalPrice,
    required this.sellPrice,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.quantity,
  });

  // Convert JSON to CartItem
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartId: json['cart_id'],
      userId: json['user_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productThumbnail: json['product_thumbnail'],
      productDescription: json['product_description'],
      normalPrice: json['normal_price'].toDouble(),
      sellPrice: json['sell_price'].toDouble(),
      discountPercentage: json['discount_percentage'].toDouble(),
      discountedPrice: json['discounted_price'].toDouble(),
      quantity: json['quantity'],
    );
  }

  // Convert CartItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'product_id': productId,
      'product_name': productName,
      'product_thumbnail': productThumbnail,
      'product_description': productDescription,
      'normal_price': normalPrice,
      'sell_price': sellPrice,
      'discount_percentage': discountPercentage,
      'discounted_price': discountedPrice,
      'quantity': quantity,
    };
  }
}
