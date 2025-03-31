part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}



class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {}

class OrderFailure extends OrderState {}
