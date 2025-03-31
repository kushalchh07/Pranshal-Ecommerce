part of 'cart_order_bloc.dart';

sealed class CartOrderEvent extends Equatable {
  const CartOrderEvent();

  @override
  List<Object> get props => [];
}
class PlaceCartOrder extends CartOrderEvent {
  final int userId;
  final String paymentMethod;
  final String deliveryLocation;
const  PlaceCartOrder(this.userId, this.paymentMethod, this.deliveryLocation);
}