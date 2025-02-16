import 'package:equatable/equatable.dart';

import '../../../data/models/cart_model.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial State
class CartInitial extends CartState {}

// Loading State
class CartLoading extends CartState {}

// Success Message State
class CartSuccess extends CartState {
  final String message;
  CartSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

// Error State
class CartError extends CartState {
  final String message;
  CartError(this.message);

  @override
  List<Object?> get props => [message];
}

// Loaded Cart Items
class CartLoaded extends CartState {
  final List<CartItem> cartItems;
  CartLoaded(this.cartItems);

  @override
  List<Object?> get props => [cartItems];
}
