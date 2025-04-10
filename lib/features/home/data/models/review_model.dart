class Review {
  final int? id;
  final int productId;
  final int userId;
  final String userName;
  final String comment;
  final double rating;
  final DateTime? createdAt;

  Review({
    this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.comment,
    required this.rating,
    this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      productId: json['product_id'],
      userId: json['user_id'],
      userName: json['user_name'],
      comment: json['comment'],
      rating: (json['rating'] as num).toDouble(),
      createdAt: DateTime.tryParse(json['created_at'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'user_id': userId,
      'user_name': userName,
      'comment': comment,
      'rating': rating,
    };
  }
}
