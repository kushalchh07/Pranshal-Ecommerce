part of 'cart_order_bloc.dart';

sealed class CartOrderEvent extends Equatable {
  const CartOrderEvent();

  @override
  List<Object> get props => [];
}
class PlaceSelectedCartOrder extends CartOrderEvent {
  final int userId;
  final List<int> productIds;
  final String paymentMethod;
  final String deliveryLocation;

  PlaceSelectedCartOrder({
    required this.userId,
    required this.productIds,
    required this.paymentMethod,
    required this.deliveryLocation,
  });
}

class PlaceFullCartOrder extends CartOrderEvent {
  final int userId;
  final String paymentMethod;
  final String deliveryLocation;

  PlaceFullCartOrder({
    required this.userId,
    required this.paymentMethod,
    required this.deliveryLocation,
  });
}
