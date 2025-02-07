part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  ProductLoadedState({required this.products});
}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState({required this.error});
}
