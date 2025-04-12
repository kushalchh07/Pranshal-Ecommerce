import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/order_repository.dart';

part 'cart_order_event.dart';
part 'cart_order_state.dart';

class CartOrderBloc extends Bloc<CartOrderEvent, CartOrderState> {
  final OrderRepository orderRepository;
  CartOrderBloc(this.orderRepository) : super(CartOrderInitial()) {
    on<PlaceSelectedCartOrder>((event, emit) async {
      emit(CartOrderLoading());
      try {
        bool result = await orderRepository.placeSelectedCartOrder(
          userId: event.userId,
          productIds: event.productIds,
          paymentMethod: event.paymentMethod,
          deliveryLocation: event.deliveryLocation,
        );
        emit(result ? CartOrderSuccess() : CartOrderFailure());
      } catch (_) {
        emit(CartOrderFailure());
      }
    });

    on<PlaceFullCartOrder>((event, emit) async {
      emit(CartOrderLoading());
      try {
        bool result = await orderRepository.placeFullCartOrder(
          userId: event.userId,
          paymentMethod: event.paymentMethod,
          deliveryLocation: event.deliveryLocation,
        );
        emit(result ? CartOrderSuccess() : CartOrderFailure());
      } catch (_) {
        emit(CartOrderFailure());
      }
    });
  }
}
