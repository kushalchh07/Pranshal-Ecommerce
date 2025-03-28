import 'package:equatable/equatable.dart';
import 'package:pranshal_ecommerce/features/home/data/models/home_model.dart';

import '../../../data/models/cart_model.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Add to Cart Event
class AddToCartEvent extends CartEvent {
  final CartItem cartItem;
  AddToCartEvent(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

// Fetch Cart Items Event
class FetchCartEvent extends CartEvent {
  final int userId;
  FetchCartEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
