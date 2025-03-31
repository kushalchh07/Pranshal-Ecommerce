import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/order_repository.dart';

part 'cart_order_event.dart';
part 'cart_order_state.dart';

class CartOrderBloc extends Bloc<CartOrderEvent, CartOrderState> {
   final OrderRepository orderRepository;
  CartOrderBloc(this.orderRepository) : super(CartOrderInitial()) {
    on<PlaceCartOrder>((event, emit) async {
      emit(CartOrderLoading());
      final success = await orderRepository.placeCartOrder(event.userId, event.paymentMethod, event.deliveryLocation);
      emit(success ? CartOrderSuccess() : CartOrderFailure());
    });
  }
}
