import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<AddToCartEvent>(_onAddToCart);
    on<FetchCartEvent>(_onFetchCart);
  }

  // Handle adding a product to cart
  Future<void> _onAddToCart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
      await cartRepository.addToCart(event.cartItem);
      emit(CartSuccess("Product added to cart successfully!"));
    } catch (e) {
      emit(CartError("Failed to add product to cart: ${e.toString()}"));
    }
  }

  // Handle fetching cart items
  Future<void> _onFetchCart(
      FetchCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
      final cartItems = await cartRepository.getCartItems(event.userId);
      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(CartError("Failed to fetch cart items: ${e.toString()}"));
    }
  }
}
