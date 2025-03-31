part of 'cart_order_bloc.dart';

sealed class CartOrderState extends Equatable {
  const CartOrderState();

  @override
  List<Object> get props => [];
}

final class CartOrderInitial extends CartOrderState {}


class CartOrderLoading extends CartOrderState {}

class CartOrderSuccess extends CartOrderState {}

class CartOrderFailure extends CartOrderState {}
