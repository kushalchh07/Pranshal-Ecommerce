part of 'categoryproduct_bloc.dart';

sealed class CategoryproductState extends Equatable {
  const CategoryproductState();

  @override
  List<Object> get props => [];
}

final class CategoryproductInitial extends CategoryproductState {}

final class CategoryproductLoading extends CategoryproductState {}

final class CategoryProductLoaded extends CategoryproductState {
  final List<Product> categoryProducts;
  const CategoryProductLoaded(this.categoryProducts);
  @override
  List<Object> get props => [categoryProducts];
}

final class CategoryproductError extends CategoryproductState {}
