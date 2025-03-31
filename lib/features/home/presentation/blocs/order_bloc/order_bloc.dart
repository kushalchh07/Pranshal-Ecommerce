import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../cart/data/models/order_cart_model.dart';
import '../../../../cart/data/repositories/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
   final OrderRepository orderRepository;
  OrderBloc(this.orderRepository) : super(OrderInitial()) {
    on<PlaceSingleOrder>((event, emit) async {
      emit(OrderLoading());
      final success = await orderRepository.placeSingleOrder(event.order);
      emit(success ? OrderSuccess() : OrderFailure());
    });
  }
}
