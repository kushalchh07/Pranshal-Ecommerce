part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}
class ProductSearchEvent extends ProductEvent {
  final String query;

  ProductSearchEvent({required this.query});
}
