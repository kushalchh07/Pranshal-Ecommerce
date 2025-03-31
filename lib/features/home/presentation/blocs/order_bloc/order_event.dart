part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceSingleOrder extends OrderEvent {
  final Order order;
  PlaceSingleOrder(this.order);
}