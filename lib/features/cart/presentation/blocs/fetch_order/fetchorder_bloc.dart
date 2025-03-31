import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pranshal_ecommerce/features/cart/data/models/order_cart_model.dart';

import '../../../data/repositories/order_repository.dart';

part 'fetchorder_event.dart';
part 'fetchorder_state.dart';

class FetchorderBloc extends Bloc<FetchorderEvent, FetchorderState> {
  final OrderRepository orderRepository;
  FetchorderBloc(this.orderRepository) : super(FetchorderInitial()) {
    on<LoadUserOrdersEvent>((event, emit) async {
      emit(FetchOrderLoadingState());
      try {
        final orders = await orderRepository.fetchUserOrders(event.userId);
        emit(FetchOrderLoadedState(orders: orders));
      } catch (e) {
        emit(FetchOrderErrorState(message: e.toString()));
      }
    });
  }
}
